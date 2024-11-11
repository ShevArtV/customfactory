<?php

namespace CustomServices;

use \PhpOffice\PhpSpreadsheet\IOFactory;

class Product extends Base
{

    /**
     * @var bool
     */
    private bool $setLog = false;
    /**
     * @var string
     */
    private string $basePath;
    /**
     * @var string
     */
    private string $corePath;
    /**
     * @var string
     */
    private string $assetsPath;

    /** @var array $statuses */
    private array $statuses;

    /** @var LoadToSelectel $loadToSelectel */
    private LoadToSelectel $loadToSelectel;

    /** @var int $workflowTVId */
    private int $workflowTVId = 15;

    protected function initialize()
    {
        parent::initialize();
        $this->basePath = $this->modx->getOption('base_path');
        $this->corePath = $this->modx->getOption('core_path');
        $this->assetsPath = $this->modx->getOption('assets_path');
        $this->statuses = $this->getStatuses();
        $this->loadToSelectel = new LoadToSelectel($this->modx);
        $this->modx->addPackage('tagger', $this->corePath . 'components/tagger/model/');
        $this->modx->addPackage('salesstatistics', MODX_CORE_PATH . 'components/salesstatistics/model/');
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
                    Data.cut AS cut,
                    Data.gender AS gender,
                    Data.count_files AS count_files,
                    Parent.pagetitle AS pagetitle, 
                    Parent.menuindex AS menuindex, 
                    Product.parent AS parent"
        );
        $q->leftJoin('modResource', 'Product', 'Data.id = Product.id');
        $q->leftJoin('modResource', 'Parent', 'Product.parent = Parent.id');
        $q->where(['Product.template' => 14, 'Parent.published' => 1, 'Parent.deleted' => 0]);
        $q->andCondition('Data.size IS NOT NULL');
        $q->andCondition([
            'Parent.id:NOT IN' => $prohibited_categories,
            'Parent.old_id:NOT IN' => $prohibited_categories,
            'Product.id:NOT IN' => $prohibited_categories,
            'Product.old_id:NOT IN' => $prohibited_categories,
        ]);
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

        $this->modx->cacheManager->set($cacheKey, $output, $this->cacheTime, $this->cacheOptions);
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
        $this->modx->cacheManager->set($cacheKey, $output, $this->cacheTime, $this->cacheOptions);
        return $output;
    }

    protected function getTagLabel(string $tag): int
    {
        $q = $this->modx->newQuery('TaggerTag');
        $q->select('label');
        $q->where(['tag' => $tag]);
        $q->prepare();
        $tstart = microtime(true);
        if ($q->prepare() && $q->stmt->execute()) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            $result = $q->stmt->fetchAll(\PDO::FETCH_COLUMN);
            return (int)$result[0];
        }
        return 0;
    }

    public function prepareFiles(array $filelist, int $rid, $folder = 'loadtoselectel/', $field = 'temp_files', $isCopy = false): void
    {
        $senditTempPath = $this->modx->getOption('si_uploaddir', '', '[[+asseetsUrl]]components/sendit/uploaded_files/');
        $senditTempPath = str_replace('[[+asseetsUrl]]', $this->assetsPath, $senditTempPath);
        $targetFolder = $this->assetsPath . $folder . $rid . '/';
        $files = [];
        if (!file_exists($targetFolder)) {
            mkdir($targetFolder, 0777, true);
        }
        foreach ($filelist as $file) {
            $sourceFile = $senditTempPath . session_id() . '/' . $file;
            if (file_exists($sourceFile)) {
                $targetFile = $targetFolder . $file;
                if (!$isCopy) {
                    rename($sourceFile, $targetFile);
                } else {
                    copy($sourceFile, $targetFile);
                }
                $files[] = str_replace($this->basePath, '', $targetFile);
            }
        }
        if (!empty($files) && $resource = $this->modx->getObject('modResource', $rid)) {
            $resource->set($field, implode('|', $files));
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
                    OR Data.article_oz LIKE :article 
                    OR Data.article_wb LIKE :article 
                    OR Profile.profile_num LIKE :profileNum)                    
            "
        );
        $q->andCondition(['msProduct.id:IN' => $rids]);
        $this->executeSearch($q, $configId, $rids, $params);
    }

    public function createProduct(array $productData): array
    {
        $log['front'] = $productData;
        $output = [
            'success' => false,
            'msg' => 'Произошла ошибка при создании дизайна.'
        ];
        if (!(int)$productData['root_id']) {
            $msg = 'Не передан ID шаблонного товара.';
            $this->setModerateLog([
                'rid' => (int)$productData['id'],
                'msg' => $msg,
                'place' => '\CustomServices\Product',
                'method' => 'createProduct',
                'productData' => $productData
            ]);
            $output['msg'] = $msg;
            return $output;
        }
        $types = $this->getProductTypes();
        if (!$types[$productData['root_id']]) {
            $msg = 'Передан недопустимый ID шаблонного товара.';
            $this->setModerateLog([
                'rid' => (int)$productData['id'],
                'msg' => $msg,
                'place' => '\CustomServices\Product',
                'method' => 'createProduct',
                'productData' => $productData
            ]);
            $output['msg'] = $msg;
            return $output;
        }
        if (!$rootProduct = $this->modx->getObject('modResource', ['class_key' => 'msProduct', 'id' => (int)$productData['root_id']])) {
            $msg = "Не удалось получить шаблонный товара по ID = {$productData['root_id']}.";
            $this->setModerateLog([
                'rid' => (int)$productData['id'],
                'msg' => $msg,
                'place' => '\CustomServices\Product',
                'method' => 'createProduct',
                'productData' => $productData
            ]);
            $output['msg'] = $msg;
            return $output;
        }

        if (!$productData['tag_label'] && !$productData['tag_label'] = $this->getTagLabel($productData['tags'][0])) {
            $msg = 'Не выбран тэг товара.';
            $this->setModerateLog([
                'rid' => (int)$productData['id'],
                'msg' => $msg,
                'place' => '\CustomServices\Product',
                'method' => 'createProduct',
                'productData' => $productData
            ]);
            $output['msg'] = $msg;
            return $output;
        }

        $productData['pagetitle'] .= date('d-m-Y H:i:s');
        $productData['alias'] .= date('d-m-Y-H-i-s');
        $defaultProductData = $rootProduct->toArray();
        unset(
            $defaultProductData['id'],
            $defaultProductData['longtitle'],
            $defaultProductData['createdon'],
            $defaultProductData['editedon'],
            $defaultProductData['article'],
            $defaultProductData['createdby'],
            $defaultProductData['profilenum'],
            $defaultProductData['designer']
        );
        $defaultProductData['template'] = 13;
        $log['root'] = $defaultProductData;
        $productData = array_merge($defaultProductData, $productData);
        if (!$productData['tag_label']) {
            $q = $this->modx->newQuery('TaggerTag');
            $q->select('label');
            $q->where(['tag' => $productData['tags'][0]]);
            $q->prepare();
            $tstart = microtime(true);
            if ($q->prepare() && $q->stmt->execute()) {
                $this->modx->queryTime += microtime(true) - $tstart;
                $this->modx->executedQueries++;
                $result = $q->stmt->fetchAll(\PDO::FETCH_COLUMN);
                $productData['tag_label'] = $result[0];
            }
            if (!$productData['tag_label']) {
                $msg = 'Не указан лейбл тэга.';
                $this->setModerateLog([
                    'rid' => (int)$productData['id'],
                    'msg' => $msg,
                    'place' => '\CustomServices\Product',
                    'method' => 'createProduct',
                    'productData' => $productData
                ]);
                $output['msg'] = $msg;
                return $output;
            }
        }

        $productData['profilenum'] = $productData['profilenum'] ?: $this->getProfileNum((int)$productData['createdby']);
        if (!$productData['profilenum']) {
            $msg = 'Не указан номер ЛК.';
            $this->setModerateLog([
                'rid' => (int)$productData['id'],
                'msg' => $msg,
                'place' => '\CustomServices\Product',
                'method' => 'createProduct',
                'productData' => $productData
            ]);
            $output['msg'] = $msg;
            return $output;
        }

        $log['mixed'] = $productData;
        /** @var \msProduct $newProduct */
        $newProduct = $this->modx->newObject('msProduct', $productData);
        $newProduct->save();
        if (strpos($productData['pagetitle'], $productData['designer']) === false) {
            $log['id'] = $newProduct->get('id');
            $log['user_id'] = $this->modx->user->get('id');
            $logPath = $this->basePath . 'assets/created-log.txt';
            file_put_contents($logPath, print_r($log, 1) . PHP_EOL, FILE_APPEND);
            $this->changeOwner($productData['pagetitle'], $newProduct);
        }

        $this->setModerateLog([
            'rid' => $newProduct->get('id'),
            'msg' => 'Дизайн создан',
            'place' => '\CustomServices\Product',
            'method' => 'createProduct',
            'productData' => array_merge($productData, $newProduct->toArray())
        ]);

        return [
            'success' => true,
            'msg' => 'Дизайн ID=' . $newProduct->get('id') . ' отправлен на модерацию.',
            'rid' => $newProduct->get('id')
        ];
    }

    protected function getProfileNum(?int $user_id): int
    {
        if ($profile = $this->modx->getObject('modUserProfile', ['internalKey' => $user_id])) {
            return (int)$profile->get('profile_num');
        }
        return 0;
    }

    public function changeOwner(string $pagetitle, \msProduct $product)
    {
        preg_match('/^Дизайн(.*?) от.*?/', $pagetitle, $matches);
        $name = trim($matches[1]);
        if ($profile = $this->modx->getObject('modUserProfile', ['fullname' => $name])) {
            $product->set('createdby', $profile->get('internalKey'));
            $product->set('designer', $profile->get('fullname'));
            $product->set('profilenum', $profile->get('profile_num'));
            $product->save();
        }
    }

    public function updateProduct(array $productData): array
    {
        $tstart = microtime(true);
        if (!$product = $this->modx->getObject('modResource', ['class_key' => 'msProduct', 'id' => (int)$productData['id']])) {
            $msg = 'Дизайн с ID=' . $productData['id'] . ' не найден.';
            $this->setModerateLog([
                'rid' => (int)$productData['id'],
                'msg' => $msg,
                'place' => '\CustomServices\Product',
                'method' => 'updateProduct',
                'productData' => $productData
            ]);
            return [
                'success' => false,
                'msg' => $msg
            ];
        }

        $monitoredFields = [
            'status' => $product->get('status') ?: 0,
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

        if ($productData['status'] !== $monitoredFields['status']) {
            $productData['prev_status'] = $monitoredFields['status'];
        }

        if ($productData['status'] == 7 && !$productData['deleted']) {
            $workflow['moderator_date'] = date('Y-m-d H:i:s');
            $workflow['moderator_comment'] = $productData['content'];
            $workflow['screens'] = strpos($product->get('temp_files'), 'assets/screenshots/') !== false ? $product->get('temp_files') : '';
            $workflow['preview'] = $product->get('preview');
            $workflow['print'] = $product->get('print');
            $workflow['designer_comment'] = $product->get('introtext');
            $workflow['designer_date'] = $product->get('createdon');
            $productData['temp_files'] = '';
            $this->setWorkflow($workflow, $product);
            $this->toggleMark('rework', $product, 'add');
        } else {
            $this->toggleMark('rework', $product);
        }

        if ($this->modx->user->isMember('Managers') && !$product->get('manager_id')) {
            $productData['manager_id'] = $this->modx->user->get('id');
        }
        if ($this->modx->user->isMember('Moderators') && !$product->get('moderator_id')) {
            $productData['moderator_id'] = $this->modx->user->get('id');
        }

        if ($productData['deleted']) {
            $this->setLog = true;
            $productData['delete_at'] = date('d.m.Y', strtotime('+7 days'));
        }

        if ($productData['root_id']) {
            if ($root = $this->modx->getObject('msProduct', $productData['root_id'])) {
                $productData['count_files'] = $root->get('count_files');
            }
            $types = $this->getProductTypes();
            if (!$types[$productData['root_id']]) {
                $msg = 'Передан недопустимый ID шаблонного товара  для товара ' . $productData['id'] . '.';
                $this->setModerateLog([
                    'rid' => (int)$productData['id'],
                    'msg' => $msg,
                    'place' => '\CustomServices\Product',
                    'method' => 'updateProduct',
                    'productData' => array_merge($productData, $product->toArray())
                ]);
                return [
                    'success' => false,
                    'msg' => $msg
                ];
            }
        }

        if ($productData['status'] == 3 && !$product->get('article')) {
            $result = $this->getArticle($product->toArray());
            $productData['article'] = $result['article'];
            if (!(int)$productData['article']) {
                $msg = 'Не удалось сгенерировать артикул для товар с ID ' . $productData['id'];
                $this->setModerateLog([
                    'rid' => (int)$productData['id'],
                    'msg' => $msg,
                    'place' => '\CustomServices\Product',
                    'method' => 'updateProduct',
                    'productData' => array_merge($productData, $product->toArray())
                ]);
                return [
                    'success' => false,
                    'msg' => $msg
                ];
            }
        }

        $productData['editedon'] = time();
        $product->fromArray($productData);
        $product->save();

        $this->sendModerateNotify($product);

        $this->flatfilters->removeResourceIndex((int)$productData['id']);
        $this->flatfilters->indexingDocument($product);

        if ($this->setLog) {
            $this->setModerateLog([
                'rid' => (int)$productData['id'],
                'msg' => 'Данные дизайна изменены',
                'place' => '\CustomServices\Product',
                'method' => 'updateProduct',
                'productData' => array_merge($productData, $product->toArray())
            ]);
        }

        return [
            'success' => true,
            'msg' => 'Дизайн обновлен.',
            'rid' => $productData['id']
        ];
    }

    public function sendModerateNotify($product)
    {
        $status = $product->get('status');
        $prevStatus = $product->get('prev_status');
        $filePrefix = $this->modx->getOption('file_prefix');
        if ($prevStatus === 7) {
            return;
        }
        switch ($status) {
            case '5':
                if ($profile = $this->modx->getObject('modUserProfile', array('internalKey' => $product->get('createdby')))) {
                    $preview = explode('|', $product->get('preview'));
                    $this->sendEmail([
                        'to' => $profile->get('email'),
                        'chunk' => '@FILE chunks/emails/designModerateRejected.tpl',
                        'params' => [
                            'reasons' => $product->get('content'),
                            'pagetitle' => $product->get('pagetitle'),
                            'preview' => $preview,
                            'filePrefix' => $filePrefix
                        ],
                        'subject' => 'Результаты модерации дизайна.'
                    ]);
                }
                break;
            case '2':
                if ($profile = $this->modx->getObject('modUserProfile', array('default_moderator' => 1))) {
                    $this->sendEmail([
                        'to' => $profile->get('email'),
                        'chunk' => '@FILE chunks/emails/designModerateNeedCheckParams.tpl',
                        'params' => array('pagetitle' => $product->get('pagetitle')),
                        'subject' => 'Результаты модерации дизайна.'
                    ]);
                }
                break;
            case '3':
                if ($profile = $this->modx->getObject('modUserProfile', [
                    'internalKey' => $product->get('manager_id'),
                    'OR:old_id' => $product->get('manager_id')
                ])) {
                    $this->sendEmail([
                        'to' => $profile->get('email'),
                        'chunk' => '@FILE chunks/emails/designModerateSuccessManager.tpl',
                        'params' => array('pagetitle' => $product->get('pagetitle')),
                        'subject' => 'Результаты проверки технических требований к дизайну.'
                    ]);
                }
                break;
            case '4':
                if ($profileUser = $this->modx->getObject('modUserProfile', array('internalKey' => $product->get('createdby')))) {
                    $this->sendEmail([
                        'to' => $profileUser->get('email'),
                        'chunk' => '@FILE chunks/emails/designModerateSuccessUser.tpl',
                        'params' => array(
                            'article_wb' => $product->get('article_wb'),
                            'article_ya' => $product->get('article_ya'),
                            'article_oz' => $product->get('article_oz'),
                            'pagetitle' => $product->get('pagetitle')
                        ),
                        'subject' => 'Результаты модерации дизайна.'
                    ]);
                }
                break;
        }
    }

    public function toggleMark($mark, $product, $method = 'remove')
    {
        if ($profile = $this->modx->getObject('modUserProfile', ['internalKey' => $product->get('createdby')])) {
            $extended = $profile->get('extended');
            if ($method === 'add') {
                $extended[$mark] = 1;
            } else {
                $extended[$mark] = 0;
            }
            $profile->set('extended', $extended);
            $profile->save();
        }
    }

    public function removeProduct(array $productData): array
    {
        $id = $productData['id'];
        $preview = $productData['preview'] ? explode('|', $productData['preview']) : [];
        $print = $productData['print'] ? explode('|', $productData['print']) : [];
        $workflow = [];
        $q = $this->modx->newQuery('modTemplateVarResource');
        $q->select('value');
        $q->where(['tmplvarid' => 15, 'contentid' => $id]);
        $q->limit(1);
        if ($q->prepare() && $q->stmt->execute()) {
            $result = $q->stmt->fetchAll(\PDO::FETCH_COLUMN);
            $workflow = $result[0] ? json_decode($result[0], true) : [];
        }

        $files = array_merge($preview, $print);
        if (!empty($files)) {
            foreach ($files as $path) {
                $this->loadToSelectel->removeContainer($path);
            }
        }

        if (!empty($workflow)) {
            $pathToScreens = $this->basePath . 'screenshots/';
            foreach ($workflow as $w) {
                if (!$w['screens']) {
                    continue;
                }
                $screens = explode('|', $w['screens']);
                foreach ($screens as $path) {
                    $fullpath = $pathToScreens . $path;
                    if (file_exists($fullpath)) {
                        unlink($fullpath);
                    }
                }
            }
        }

        $this->flatfilters->removeResourceIndex($id);

        $this->setModerateLog([
            'rid' => $id,
            'msg' => 'Дизайн удалён по расписанию.',
            'place' => '\CustomServices\Product',
            'method' => 'removeProduct',
            'productData' => $productData
        ]);

        if ($product = $this->modx->getObject('msProduct', $id)) {
            $product->remove();
        }

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
                $result = $this->updateProduct(['id' => $selectedId, $key => $value, 'content' => $data['content']]);
                if (!$result['success']) {
                    $this->modx->log(1, '[Product::setProductsField] ' . $result['msg']);
                }
            }
        }
        return $selectedIds;
    }

    public function checkChanges($key, $oldValue, $newValue, $rid)
    {
        switch ($key) {
            case 'status':
                if ($oldValue !== $newValue && is_array($this->statuses['product'][$oldValue]) && !in_array($newValue, $this->statuses['product'][$oldValue]['allow'])) {
                    $newValue = $oldValue;
                }
                $this->setLog = $newValue !== $oldValue;
                break;

            case 'tags':
            case 'color':
                $this->setLog = !empty(array_diff($newValue, $oldValue));
                break;
            default:
                $this->setLog = $newValue !== $oldValue;
                break;
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

        if (!$root = $this->modx->getObject('msProductData', $productData['root_id'])) {
            return [
                'success' => false,
                'msg' => 'Не удалось получить шаблонный товар.'
            ];
        }

        $productData['profilenum'] = (int)$productData['profilenum'] ?: $this->getProfileNum((int)$productData['createdby']);
        if ($productData['profilenum'] === 0) {
            return [
                'success' => false,
                'msg' => 'Не удалось получить номер ЛК.',
                'article' => ''
            ];
        }

        $articlePrefix = $root->get('article');
        $number = trim($setting->get('value'));
        $profile_num = $productData['profilenum'];
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
            ],
            'Футболки' => [
                'article_barcode' => 'Артикул для штрих кода',
                'name_barcode' => 'Название для штрихкода'
            ]
        ];
    }

    public function renderProducts($properties): array
    {
        if (!$properties['tpl']) {
            return $properties['resources'];
        }
        $resources = explode(',', $properties['resources']);

        $lists = [
            'categories' => $this->getParents(true),
            'types' => $this->getProductTypes(true),
            'colors' => $this->getColors(),
            'allTags' => $this->getTagsByAlphabet(),
            'statuses' => $this->getStatuses(),
        ];
        $html = '';
        $q = $this->modx->newQuery('msProduct');
        $q->setClassAlias('Product');
        $q->leftJoin('msProductData', 'Data');
        $q->leftJoin('modTemplateVarResource', 'TV', 'Product.id = TV.contentid AND TV.tmplvarid = 15');
        $q->select(['Product.*', 'Data.*', 'TV.value as workflow']);
        $q->where(['Product.id:IN' => $resources]);
        if ($properties['where']) {
            $q->andCondition($properties['where']);
        }
        $q->sortby('FIELD(Product.id, ' . $properties['resources'] . ')', '');
        $q->prepare();
        $tstart = microtime(true);
        if ($q->stmt->execute()) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            $count = $q->stmt->rowCount();
            $result = $q->stmt->fetchAll(\PDO::FETCH_ASSOC);
            if (isset($properties['limit']) && isset($properties['offset'])) {
                $result = array_slice($result, $properties['offset'] ?: 0, $properties['limit']);
            }

            foreach ($result as $row) {
                $row = array_merge($properties, $row, $lists);
                $row['color'] = $row['color'] ? json_decode($row['color'], true) : [];
                $row['tags'] = $row['tags'] ? json_decode($row['tags'], true) : [];
                $row['workflow'] = $row['workflow'] ? json_decode($row['workflow'], true) : [];
                $html .= $this->pdoTools->getChunk($properties['tpl'], $row);
            }
        }

        return ['html' => $html, 'count' => $count];
    }

    public function renderOrders($properties): array
    {
        if (!$properties['tpl']) {
            return $properties['resources'];
        }

        $resources = !is_array($properties['resources']) ? explode(',', $properties['resources']) : $properties['resources'];
        $html = '';
        $statistic = $this->getStatistic($resources);

        $q = $this->modx->newQuery('msProduct');
        $q->setClassAlias('Product');
        $q->leftJoin('msProductData', 'Data');
        $q->select([
            'Product.pagetitle AS pagetitle',
            'Product.id AS id',
            'Product.createdon AS createdon',
            'Data.preview AS preview',
            'Data.article AS article',
            'Data.root_id AS root_id',
            'Data.price AS price',
        ]);
        $q->where(['Product.id:IN' => $resources]);
        if ($properties['where']) {
            $q->andCondition($properties['where']);
        }
        $q->sortby('FIELD(Product.id, ' . $properties['resources'] . ')', '');
        $q->groupby('Product.id');
        $tstart = microtime(true);
        if ($q->prepare() && $q->stmt->execute()) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            $result = $q->stmt->fetchAll(\PDO::FETCH_ASSOC);
            foreach ($result as $row) {
                $row = array_merge($properties, $row, $statistic[$row['id']] ?? []);
                $html .= $this->pdoTools->getChunk($properties['tpl'], $row);
            }
        }

        return ['html' => $html];
    }

    public function getStatistic($resources, $total = ''): array
    {
        $statistic = [];
        $q = $this->modx->newQuery('SalesStatisticsItem');
        $q->select([
            "product_id as {$total}id",
            "SUM(`sales`) AS {$total}sales",
            "SUM(`returns`) AS {$total}returns",
            "SUM(`orders`) AS {$total}orders",
            "SUM(`pays`) as {$total}pays",
            "MIN(`date`) as {$total}min",
            "MAX(`date`) as {$total}max",
        ]);
        $q->where(['product_id:IN' => $resources]);
        if ($_REQUEST['date']) {
            $dates = explode(',', $_REQUEST['date']);
            $start = strtotime($dates[0]);
            $end = strtotime($dates[1]);
            $q->andCondition("date BETWEEN $start AND $end");
        }
        if ($_REQUEST['market']) {
            $q->andCondition(['market:IN' => !is_array($_REQUEST['market']) ? explode(',', $_REQUEST['market']) : $_REQUEST['market']]);
        }
        if ($_REQUEST['sortby']) {
            $sortby = explode('|', $_REQUEST['sortby']);
            $q->sortby($sortby[0], $sortby[1]);
        }
        if (!$total) {
            $q->groupby('product_id');
        }
        $tstart = microtime(true);
        if ($q->prepare() && $q->stmt->execute()) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            $result = $q->stmt->fetchAll(\PDO::FETCH_ASSOC);
            foreach ($result as $item) {
                $prefix = $total ? str_replace('_', '', $total) : '';
                $item[$total . 'min'] = date('d.m.Y', $item[$total . 'min']);
                $item[$total . 'max'] = date('d.m.Y', $item[$total . 'max']);
                $statistic[$prefix . $item['id']] = $item;
            }
        }

        return $statistic;
    }

    public function getColors(): array
    {
        $cacheKey = 'getColors::cache';
        if ($output = $this->modx->cacheManager->get($cacheKey)) {
            return $output;
        }
        $q = $this->modx->newQuery('modTemplateVarResource');
        $q->select('value');
        $q->where(['modTemplateVarResource.contentid' => 51982, 'modTemplateVarResource.tmplvarid' => 13]);
        $q->prepare();
        $tstart = microtime(true);
        if ($q->prepare() && $q->stmt->execute()) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            $result = $q->stmt->fetch(\PDO::FETCH_COLUMN);
            $output = explode(',', $result);
            $this->modx->cacheManager->set($cacheKey, $output, $this->cacheTime, $this->cacheOptions);
            return $output;
        }
        return [];
    }

    public function loadWorkflow($id)
    {
        $productData = [];
        $q = $this->modx->newQuery('modResource');
        $q->setClassAlias('Resource');
        $q->leftJoin('msProductData', 'Data');
        $q->leftJoin(
            'modTemplateVarResource',
            'Workflow',
            "Workflow.contentid = Data.id AND Workflow.tmplvarid = $this->workflowTVId"
        );
        $q->select(
            'Data.tags as tags,
         Data.color as color,
         Data.count_files as count_files,
         Data.status as status,
         Data.prev_status as prev_status,
         Data.root_id as root_id,
         Data.print as print,
         Data.preview as preview,
         Resource.introtext as introtext,
         Workflow.value as workflow'
        );
        $q->where([
            'Data.id' => $id,
        ]);
        $q->prepare();

        if ($q->stmt->execute()) {
            $productData = $q->stmt->fetch(\PDO::FETCH_ASSOC);
        }
        if (empty($productData)) {
            return [
                'success' => false,
                'msg' => 'Товар не найден',
                'html' => ''
            ];
        }

        $workflow = $productData['workflow'] ? json_decode($productData['workflow'], true) : [];
        $statuses = $this->getStatuses();
        $types = $this->getProductTypes();

        if (empty($workflow)) {
            $workflow[] = [
                'print' => $productData['print'],
                'preview' => $productData['preview'],
                'designer_comment' => $productData['introtext'],
            ];
        }

        if (!$productData['count_files']) {
            if (!$root = $this->modx->getObject('msProductData', $productData['root_id'])) {
                return [
                    'success' => false,
                    'msg' => 'Шаблонный товар не найден',
                    'html' => ''
                ];
            }
            $productData['count_files'] = $root->get('count_files');
        }
        $params = [
            'id' => $id,
            'tags' => $productData['tags'] ? json_decode($productData['tags'], true) : [],
            'color' => $productData['color'] ? json_decode($productData['color'], true) : [],
            'count_files' => $productData['count_files'],
            'statuses' => $statuses,
            'status' => $productData['status'],
            'prev_status' => $productData['prev_status'],
            'type' => $types[$productData['root_id']],
            'workflow' => $workflow,
        ];

        $tpl = '@FILE chunks/common/workflow_designer.tpl';
        if ($this->modx->user->isMember(['Moderators', 'Managers'])) {
            $tpl = '@FILE chunks/common/workflow_moderator.tpl';
        }

        $html = $this->pdoTools->getChunk($tpl, $params);

        return [
            'success' => true,
            'msg' => '',
            'html' => $html
        ];
    }

    public function getProductsFromFile(string $path, int $page = 1, int $limit = 6): array
    {
        $offset = $page === 1 ? 0 : $limit * ($page - 1);
        $senditTempPath = $this->modx->getOption('si_uploaddir', '', '[[+asseetsUrl]]components/sendit/uploaded_files/');
        $senditTempPath = str_replace('[[+asseetsUrl]]', $this->assetsPath, $senditTempPath);
        $fullPath = $senditTempPath . session_id() . '/' . $path;
        $articles = [];
        $spreadsheet = IOFactory::load($fullPath);
        $worksheet = $spreadsheet->getActiveSheet();
        $highestRow = $worksheet->getHighestRow();

        for ($row = 2; $row <= $highestRow; $row++) {
            $articles[] = trim($worksheet->getCell('A' . $row)->getValue());
        }

        if (empty($articles)) {
            return [
                'success' => false,
                'msg' => 'Файл пуст',
                'html' => ''
            ];
        }
        $ids = [];
        $q = $this->modx->newQuery('msProductData');
        $q->setClassAlias('Data');
        $q->select('Data.id');
        $q->where(['Data.article:IN' => $articles]);
        if ($_REQUEST['selectedIds']) {
            $selectedIds = $_SESSION['selectedIds'] ?: [];
            $selectedIds = array_unique(array_merge($selectedIds, json_decode($_REQUEST['selectedIds'])));
            $q->where(['Data.id:NOT IN' => $selectedIds]);
            $_SESSION['selectedIds'] = $selectedIds;
        }
        $q->prepare();
        $tstart = microtime(true);
        if ($q->stmt->execute()) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            $ids = $q->stmt->fetchAll(\PDO::FETCH_COLUMN);
        }

        if (empty($ids)) {
            return [
                'success' => false,
                'msg' => 'Не найдено ни одного товара.',
                'html' => ''
            ];
        }

        $result = $this->renderProducts([
            'tpl' => '@FILE chunks/getproductsfromfile/default/item.tpl',
            'resources' => implode(',', $ids),
            'where' => ['Product.deleted:!=' => 1],
            'limit' => $limit,
            'offset' => $offset
        ]);

        return [
            'success' => true,
            'msg' => '',
            'html' => $result['html'],
            'totalResults' => $result['count'],
            'totalPages' => ceil($result['count'] / $limit),
            'currentPage' => $page
        ];
    }

    public function getDefaultProducts(array $data): string
    {
        $output = [];
        $q = $this->modx->newQuery('msProductData');
        $q->setClassAlias('Data');
        $q->select(
            "Data.popular AS popular, 
                    Data.new AS new,
                    Data.price AS price,
                    Product.uri AS uri,
                    Product.pagetitle AS pagetitle,
                    Parent.pagetitle AS category, 
                    Parent.menuindex AS menuindex,
                    TV.value as img, 
                    Product.parent AS parent"
        );
        $q->leftJoin('modResource', 'Product', 'Data.id = Product.id');
        $q->leftJoin('modResource', 'Parent', 'Product.parent = Parent.id');
        $q->leftJoin('modTemplateVarResource', 'TV', 'Product.id = TV.contentid AND TV.tmplvarid = 1');
        $q->where(['Product.template' => 14, 'Parent.published' => 1, 'Parent.deleted' => 0]);
        if ($data['parent']) {
            $q->andCondition(['Product.parent:IN' => json_decode($data['parent'], true)]);
        }
        $q->sortby('Parent.menuindex');
        if ($data['sortby']) {
            $sortby = explode('|', $data['sortby']);
            $q->sortby($sortby[0], $sortby[1]);
        } else {
            $q->sortby('Product.id', 'DESC');
        }
        $tstart = microtime(true);
        if ($q->prepare() && $q->stmt->execute()) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            $result = $q->stmt->fetchAll(\PDO::FETCH_ASSOC);
            foreach ($result as $item) {
                $output[$item['category']][] = $item;
            }
        }
        return $this->pdoTools->getChunk('@FILE chunks/getdefaultproducts/default/item.tpl', ['categories' => $output]);
    }

    public function importArticles(): void
    {
        $path = $this->assetsPath . 'obmen/номенклатура.json';
        if (!file_exists($path)) {
            return;
        }
        if (!$importData = file_get_contents($path)) {
            return;
        }
        $importData = json_decode($importData, true);

        foreach ($importData as $data) {
            $q = $this->modx->newQuery('modResource');
            $q->leftJoin('msProductData', 'Data');
            $q->where(['Data.article' => $data['Артикул']]);
            if ($r = $this->modx->getObject('modResource', $q)) {
                $r->set('article_wb', $data['АртикулWB']);
                $r->set('article_oz', $data['OzonID']);
                $r->set('article_ya', $data['Артикул']);
                $r->save();

                $this->flatfilters->removeResourceIndex((int)$r->get('id'));
                $this->flatfilters->indexingDocument($r);

                $this->setModerateLog([
                    'rid' => $r->get('id'),
                    'msg' => 'Установлены артикулы',
                    'place' => '\CustomServices\Product',
                    'method' => 'importArticles',
                    'productData' => $r->toArray(),
                ]);
            }
        }
    }

    public function getReportData(array $fields, array $conditions = []): array
    {
        $data['className'] = 'msProduct';
        $data['names'] = array_keys($fields);
        $data['captions'] = $fields;
        $q = $this->modx->newQuery('msProduct');
        $q->leftJoin('msProductData', 'Data');
        $q->select('msProduct.id as id');
        $q->where($conditions);
        $q->prepare();
        $tstart = microtime(true);
        if ($q->stmt->execute()) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            $data['ids'] = $q->stmt->fetchAll(\PDO::FETCH_COLUMN);
        }
        return $data;
    }

    public function getProductVariations(array $where)
    {
        $output = [];
        $q = $this->modx->newQuery('modResource');
        $q->leftJoin('msProductData', 'Data');
        $q->select('modResource.id');
        $q->select($this->modx->getSelectColumns('msProductData', 'Data', '', ['id'], true));
        $q->select($this->modx->getSelectColumns('modResource', 'modResource', '', ['id'], true));
        $q->where($where);
        $q->prepare();
        if ($q->stmt->execute()) {
            $output = $q->stmt->fetchAll(\PDO::FETCH_GROUP | \PDO::FETCH_ASSOC);
        }
        return $output;
    }
}
