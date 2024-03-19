<?php

namespace CustomServices;

use CustomServices\LoadToSelectel;

class Product extends Base
{
    /**
     * @var array|mixed|string
     */
    private $basePath;
    /**
     * @var array|mixed|string
     */
    private $corePath;
    /**
     * @var array|mixed|string
     */
    private $assetsPath;

    /** @var array $statuses */
    private array $statuses;

    /** @var LoadToSelectel $loadToSelectel */
    private LoadToSelectel $loadToSelectel;

    protected function initialize()
    {
        parent::initialize();
        $this->basePath = $this->modx->getOption('base_path');
        $this->corePath = $this->modx->getOption('core_path');
        $this->assetsPath = $this->modx->getOption('assets_path');
        $this->statuses = $this->getStatuses();
        $this->loadToSelectel = new LoadToSelectel($this->modx);
        $this->modx->addPackage('tagger', $this->corePath . 'components/tagger/model/');
    }

    public function getDesignTemplates($prohibited_categories = '9999999999'): array
    {
        $cacheKey = 'getDesignTemplates::' . $prohibited_categories;
        if ($output = $this->modx->cacheManager->get($cacheKey)) {
            return $output;
        }
        $prohibited_categories = explode(',', $prohibited_categories);
        $output = [];
        $q = $this->modx->newQuery('msProductData');
        $q->setClassAlias('Data');
        $q->select(
            "Data.size AS size, 
                    Data.id AS root_id,
                    Data.count_files AS count_files,
                    Parent.pagetitle AS pagetitle, 
                    Parent.menuindex AS menuindex, 
                    Product.parent AS parent"
        );
        $q->leftJoin('modResource', 'Product', 'Data.id = Product.id');
        $q->leftJoin('modResource', 'Parent', 'Product.parent = Parent.id');
        $q->where(['Product.template' => 14, 'Parent.published' => 1, 'Parent.deleted' => 0]);
        $q->andCondition('Data.size IS NOT NULL');
        $q->andCondition(['Parent.id:NOT IN' => $prohibited_categories, 'Parent.old_id:NOT IN' => $prohibited_categories]);
        $q->sortby('Parent.menuindex');

        $tstart = microtime(true);
        if ($q->prepare() && $q->stmt->execute()) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            $result = $q->stmt->fetchAll(\PDO::FETCH_ASSOC);
            foreach ($result as $item) {
                $size = json_decode($item['size'], true);
                $output[$item['pagetitle']]['parent'] = $item['parent'];
                $output[$item['pagetitle']]['sizes'][$size[0]] = $item;
            }
        }
        $this->modx->cacheManager->set($cacheKey, $output);
        return $output;
    }

    public function getTagsByAlphabet($query = '')
    {
        $cacheKey = 'getTagsByAlphabet::' . $query;
        if ($output = $this->modx->cacheManager->get($cacheKey)) {
            return $output;
        }

        $q = $this->modx->newQuery('TaggerTag');
        $q->select('label, tag');
        if ($query) {
            $q->where(['tag:LIKE' => "{$query}%"]);
        }
        $q->prepare();

        $tstart = microtime(true);
        if ($q->prepare() && $q->stmt->execute()) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            $result = $q->stmt->fetchAll(\PDO::FETCH_ASSOC);
            foreach ($result as $item) {
                $firstChar = mb_substr($item['tag'], 0, 1);
                $key = is_numeric($firstChar) ? 'A_Цифры' : $firstChar;
                $output[$key][$item['label']] = $item['tag'];
            }
            if (!empty($output)) {
                ksort($output);
            }
        }
        $this->modx->cacheManager->set($cacheKey, $output);
        return $output;
    }

    public function prepareFiles(array $filelist, int $rid)
    {
        $senditTempPath = $this->modx->getOption('si_uploaddir', '', '[[+asseetsUrl]]components/sendit/uploaded_files/');
        $senditTempPath = str_replace('[[+asseetsUrl]]', $this->assetsPath, $senditTempPath);
        $targetFolder = $this->assetsPath . 'loadtoselectel/' . $rid . '/';
        $files = [];
        if (!file_exists($targetFolder)) {
            mkdir($targetFolder, 0777, true);
        }
        foreach ($filelist as $file) {
            $sourceFile = $senditTempPath . session_id() . '/' . $file;
            if (file_exists($sourceFile)) {
                $targetFile = $targetFolder . $file;
                rename($sourceFile, $targetFile);
                $files[] = str_replace($this->basePath, '', $targetFile);
            }
        }
        if (!empty($files) && $resource = $this->modx->getObject('modResource', $rid)) {
            $resource->set('temp_files', implode('|', $files));
            $resource->save();
        }
    }

    public function searchProducts(string $query, string $rids, int $configId)
    {
        $tag = mb_substr($query, 0, 1, "UTF-8");
        $tag = mb_strtoupper($tag, "UTF-8") . mb_substr($query, 1, null, "UTF-8");
        $color = mb_strtolower(trim($query));
        $pagetitle = $article = $profileNum = "%{$query}%";
        $rids = explode(',', $rids);
        $params = array(
            ':tag' => $tag,
            ':color' => $color,
            ':pagetitle' => $pagetitle,
            ':article' => $article,
            ':profileNum' => $profileNum,
        );

        $q = $this->modx->newQuery('msProduct');
        $q->leftJoin('msProductData', 'Data');
        $q->leftJoin('modUserProfile', 'Profile', 'Profile.id = msProduct.createdby');
        $q->select('msProduct.id as id');
        $q->where(
            "
                    (JSON_SEARCH(Data.tags, 'one', :tag) IS NOT NULL
                    OR JSON_SEARCH(Data.color, 'one', :color) IS NOT NULL
                    OR msProduct.pagetitle LIKE :pagetitle
                    OR Data.article LIKE :article 
                    OR Profile.profile_num LIKE :profileNum)                    
            "
        );
        $q->andCondition(['msProduct.id:IN' => $rids]);
        $this->executeSearch($q, $configId, $rids, $params);
    }

    public function createProduct(array $productData): array
    {
        $output = [
            'success' => false,
            'msg' => 'Произошла ошибка при создании дизайна.'
        ];
        if (!(int)$productData['root_id']) {
            $output['msg'] = 'Не передан ID шаблонного товара.';
            return $output;
        }
        if (!$rootProduct = $this->modx->getObject('modResource', ['class_key' => 'msProduct', 'id' => (int)$productData['root_id']])) {
            $output['msg'] = "Не удалось получить шаблонный товара по ID = {$productData['root_id']}.";
            return $output;
        }

        $defaultProductData = $rootProduct->toArray();
        unset($defaultProductData['id'], $defaultProductData['longtitle']);
        $defaultProductData['template'] = 13;
        $productData = array_merge($defaultProductData, $productData);
        $newProduct = $this->modx->newObject('msProduct', $productData);
        $newProduct->save();
        $result = $this->getArticle($newProduct->toArray());
        if (!$result['success']) {
            return $result;
        }

        $newProduct->set('article', $result['article']);
        $newProduct->save();

        return [
            'success' => true,
            'msg' => 'Дизайн отправлен на модерацию.',
            'rid' => $newProduct->get('id')
        ];
    }

    public function updateProduct(array $productData): array
    {
        if (!$product = $this->modx->getObject('modResource', ['class_key' => 'msProduct', 'id' => (int)$productData['id']])) {
            return [
                'success' => false,
                'msg' => 'Произошла ошибка при обновлении дизайна.'
            ];
        }
        $productData['prev_status'] = $product->get('status') ?: 0;
        $monitoredFields = [
            'status' => $productData['prev_status'],
            'parent' => $product->get('parent'),
            'root_id' => $product->get('root_id'),
            'tags' => $product->get('tags'),
            'color' => $product->get('color'),
        ];

        foreach ($monitoredFields as $key => $value) {
            if (!isset($productData[$key])) {
                continue;
            }
            $productData[$key] = $this->checkChanges($key, $value, $productData[$key], (int)$productData['id']);
        }

        if($productData['root_id'] && $root = $this->modx->getObject('msProduct', $productData['root_id'])) {
            $files = $product->get('print') ? explode('|', $product->get('print')) : [];
            if(count($files) !== $root->get('count_files')){
                $productData['root_id'] = $monitoredFields['root_id'];
            }
        }

        $product->fromArray($productData);
        $product->save();

        $this->flatfilters->removeResourceIndex((int)$productData['id']);
        $this->flatfilters->indexingDocument($product);

        return [
            'success' => true,
            'msg' => 'Дизайн обновлен.',
            'rid' => $productData['id']
        ];
    }


    public function removeProduct(\msProduct $product): array
    {
        $id = $product->get('id');
        $preview = $product->get('preview') ? explode('|', $product->get('preview')) : [];
        $print = $product->get('print') ? explode('|', $product->get('print')) : [];
        $files = array_merge($preview, $print);
        if (!empty($files)) {
            foreach ($files as $path) {
                $this->loadToSelectel->removeContainer($path);
            }
        }

        $this->flatfilters->removeResourceIndex($id);

        $product->remove();

        return [
            'success' => true,
            'msg' => 'Дизайн удалён.',
            'rid' => $id
        ];
    }

    public function changeStatus($data)
    {
        return [
            'success' => true,
            'msg' => 'Статус изменен.',
            'selectedIds' => $this->setProductsField($data, 'status')
        ];
    }

    public function changeParent($data)
    {
        return [
            'success' => true,
            'msg' => 'Категория изменен.',
            'selectedIds' => $this->setProductsField($data, 'parent')
        ];
    }

    public function changeRootId($data)
    {
        return [
            'success' => true,
            'msg' => 'Тип изменен.',
            'selectedIds' => $this->setProductsField($data, 'root_id')
        ];
    }

    public function changeTags($data)
    {
        return [
            'success' => true,
            'msg' => 'Тэги изменены.',
            'selectedIds' => $this->setProductsField($data, 'tags')
        ];
    }

    public function changeColor($data)
    {
        return [
            'success' => true,
            'msg' => 'Цвета изменены.',
            'selectedIds' => $this->setProductsField($data, 'color')
        ];
    }

    public function changeDeleted($data)
    {
        return [
            'success' => true,
            'msg' => 'Удалено.',
            'selectedIds' => $this->setProductsField($data, 'deleted')
        ];
    }

    public function setProductsField(array $data, string $key): array
    {
        $selectedIds = !is_array($data['selected_id']) ? json_decode($data['selected_id'], true) : $data['selected_id'];
        $productData = !is_array($data['data']) ? json_decode($data['data'], true) : $data['data'];
        if (!empty($selectedIds)) {
            foreach ($selectedIds as $selectedId) {
                $value = $productData[$selectedId][$key];
                if ($key === 'status') {
                    $value = $data[$key];
                }
                if ($key === 'deleted') {
                    $value = 1;
                }
                $result = $this->updateProduct(['id' => $selectedId, $key => $value]);
                if (!$result['success']) {
                    $this->modx->log(1, '[Designer::setProductsField] ' . $result['msg']);
                }
            }
        }
        return $selectedIds;
    }


    public function checkChanges($key, $oldValue, $newValue, $rid)
    {
        switch ($key) {
            case 'status':
                $this->modx->log(1, print_r($this->statuses, 1));
                if ($oldValue !== $newValue && is_array($this->statuses['product'][$oldValue]) && !in_array($newValue, $this->statuses['product'][$oldValue]['allow'])) {
                    $this->modx->log(1, print_r($oldValue, 1));
                    $this->modx->log(1, print_r($newValue, 1));
                    $newValue = $oldValue;
                }
                $setLog = $newValue !== $oldValue;
                break;

            case 'tags':
            case 'color':
                $setLog = !empty(array_diff($newValue, $oldValue));
                break;
            default:
                $setLog = $newValue !== $oldValue;
                break;
        }

        if ($setLog) {
            $this->setModerateLog($key, $oldValue, $newValue, $rid);
        }

        return $newValue;
    }


    public function getArticle(array $productData): array
    {
        if (!$setting = $this->modx->getObject('cgSetting', ['key' => 'design_order_number'])) {
            return [
                'success' => false,
                'msg' => 'Не установлен порядковый номер дизайна.'
            ];
        }
        $articlePrefix = $productData['article'];
        $number = trim($setting->get('value'));
        $profile_num = $productData['profile_num'];
        $tagLabel = trim($productData['tag_label']);
        list($article, $number) = $this->checkDouble($articlePrefix, $tagLabel, $number, $profile_num, $productData['id']);
        $setting->set('value', $number);
        $setting->save();
        return ['success' => true, 'article' => $article];
    }

    private function checkDouble($articlePrefix, $tagLabel, $number, $profile_num, $rid)
    {
        $n = sprintf('%07d', ++$number);
        $article = "{$articlePrefix}{$tagLabel}-{$n}-{$profile_num}";
        $output[1] = $number;
        $output[0] = $article;
        if ($this->modx->getCount('msProductData', ['article' => $article, 'id:!=' => $rid])) {
            $output = $this->checkDouble($articlePrefix, $tagLabel, $number, $profile_num, $rid);
        }
        return $output;
    }

    public function getProductFields()
    {
        return [
            'Общие' => [
                'pagetitle' => 'Название',
                'parent' => 'Категория',
                'root_id' => 'Тип товара',
                'article' => 'Артикул',
                'article_ya' => 'Артикул Яндекс',
                'article_wb' => 'Артикул WB',
                'article_oz' => 'Артикул Ozon',
                'tags' => 'Тег',
                'color' => 'Цвета',
                'status' => 'Статус',
                'prev_status' => 'Предыдущий Статус',
                'price' => 'Цена',
            ]
        ];
    }
}