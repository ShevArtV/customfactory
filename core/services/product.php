<?php

namespace CustomServices;

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

    protected function initialize()
    {
        $this->basePath = $this->modx->getOption('base_path');
        $this->corePath = $this->modx->getOption('core_path');
        $this->assetsPath = $this->modx->getOption('assets_path');
        $this->modx->addPackage('tagger', $this->corePath . 'components/tagger/model/');
    }

    public function getDesignTemplates($prohibited_categories = '9999999999'): array
    {
        $prohibited_categories = explode(',', $prohibited_categories);
        $output = [];
        $q = $this->modx->newQuery('msProductData');
        $q->setClassAlias('Data');
        $q->select("Data.size AS size, 
                           Data.id AS root_id,
                           Data.count_files AS count_files,
                           Parent.pagetitle AS pagetitle, 
                           Parent.menuindex AS menuindex, 
                           Product.parent AS parent");
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

        return $output;
    }

    public function getTagsByAlphabet($query = '')
    {
        $output = [];
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
            ksort($output);
        }

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
            $resource->set('print', implode('|', $files));
            $resource->save();
        }
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
}