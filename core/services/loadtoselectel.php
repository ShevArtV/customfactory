<?php

namespace CustomServices;

class LoadToSelectel extends Base
{
    /* @var string */
    private string $basePath;

    /**
     * @param \modX $modx
     */
    function __construct(\modX $modx)
    {
        $this->modx = $modx;
        $this->initialize();
    }

    /**
     * @return bool
     */
    protected function initialize(): void
    {
        parent::initialize();
        $this->basePath = $this->modx->getOption('base_path');
        $filesource = 3;
        $ctx = 'web';
        if (!$this->getMediaSource($filesource, $ctx)) {
            $this->modx->log(1, '[LoadToSelectel] Failed to get media source object while uploading files');
        }
    }

    /**
     * @param int $filesource
     * @param string $context
     * @return \modMediaSource|boolean
     */
    private function getMediaSource(int $filesource, string $context)
    {
        if (empty($this->mediaSource)) {
            $this->modx->loadClass('sources.modMediaSource');

            $this->mediaSource = \modMediaSource::getDefaultSource($this->modx, $filesource);

            $this->mediaSource->set('ctx', $context);
            $this->mediaSource->initialize();
        }

        return $this->mediaSource;
    }

    /**
     * @return bool
     */
    public function startUploading(): bool
    {
        if (!$this->mediaSource) {
            $this->modx->log(1, '[LoadToSelectel::initialize] Не удалось получить медиа источник.');
            return false;
        }

        $products = $this->getProducts();
        $this->prepareLoading($products);
        //$this->modx->log(1, print_r('[LoadToSelectel::initialize] Загрузка завершена', 1));
        return true;
    }

    public function generatePreviews(): int
    {
        $products = $this->getNoPreviewProducts();
        $c = 0;
        foreach ($products as $product) {
            $filelist = explode('|', $product->get('print'));
            if (empty($filelist)) {
                continue;
            }

            $rid = $product->get('id');
            $createdby = $product->get('createdby');
            $internalPath = $this->preparePath($createdby . '/' . $rid . '/{day}-{month}-{year}-{time}/');
            if (!$filesData = $this->getProductPreviews($filelist)) {
                continue;
            }

            if (!$fileInfo = $this->uploadFiles($filesData, $internalPath)) {
                continue;
            }
            $files = [];
            foreach ($fileInfo as $info) {
                $files[] = $info['path'];
            }

            if (!empty($files)) {
                $product->set('preview', implode('|', $files));
                $this->removeFiles($filesData);
                $this->removeEmptyDir(dirname($filesData[0]['tmp_name']));
                $product->save();
                $c++;
            }
        }
        return $c;
    }

    /**
     * @return \xPDOIterator
     */
    private function getNoPreviewProducts(): \xPDOIterator
    {
        if (!$parents = $this->getParents()) {
            $this->modx->log(1, '[LoadToSelectel::initialize] Не удалось получить список родителей.');
        }
        $parents = array_keys($parents);


        $q = $this->modx->newQuery('modResource');
        $q->leftJoin('msProductData', 'msProductData', 'modResource.id = msProductData.id');
        $q->where([
            'modResource.parent:IN' => $parents,
            'modResource.class_key' => 'msProduct',
            'modResource.template' => 13,
            'modResource.deleted' => 0,
        ]);
        $q->andCondition('(msProductData.preview IS NULL)');
        $q->limit(2);
        return $this->modx->getIterator('modResource', $q);
    }

    /**
     * @return \xPDOIterator
     */
    private function getProducts(): \xPDOIterator
    {
        if (!$parents = $this->getParents()) {
            $this->modx->log(1, '[LoadToSelectel::initialize] Не удалось получить список родителей.');
        }
        $parents = array_keys($parents);

        $q = $this->modx->newQuery('modResource');
        $q->leftJoin('msProductData', 'msProductData', 'modResource.id = msProductData.id');
        $q->where([
            'modResource.parent:IN' => $parents,
            'modResource.class_key' => 'msProduct',
            'modResource.template' => 13,
            'modResource.deleted' => 0,
        ]);
        $q->andCondition('(msProductData.status = 0 OR msProductData.prev_status = 7)');

        return $this->modx->getIterator('modResource', $q);
    }

    /**
     * @param \xPDOIterator $products
     * @return void
     */
    private function prepareLoading(\xPDOIterator $products): void
    {
        foreach ($products as $product) {
            $status = (int)$product->get('status') ?: 1;
            $prevStatus = (int)$product->get('prev_status') ?: 0;
            $workflow = [];
            $tempFiles = $product->get('temp_files');
            $filelist = $tempFiles ? explode('|', $tempFiles) : [];
            foreach ($filelist as $key => $file) {
                if (!file_exists($this->basePath . $file)) {
                    unset($filelist[$key]);
                }
            }
            $flag = 0;
            if (empty($filelist) && !$product->get('print')) {
                if ($status === 1 && $prevStatus === 0) {
                    $product->set('deleted', 1);
                    $product->save();
                    $this->setModerateLog([
                        'rid' => (int)$product->get('id'),
                        'msg' => 'Товар удалён автоматически из-за отсутствия изображений',
                        'place' => '\CustomServices\LoadToSelectel',
                        'method' => 'prepareLoading',
                        'productData' => $product->toArray()
                    ]);
                    $this->flatfilters->removeResourceIndex((int)$product->get('id'));
                }
                continue;
            }

            $rid = $product->get('id');
            $createdby = $product->get('createdby');
            $keys = ['print', 'preview'];
            if (!$filesData = $this->getProductFiles($filelist)) {
                continue;
            }

            $internalPath = $this->preparePath($createdby . '/' . $rid . '/{day}-{month}-{year}-{time}/');
            $path = $this->mediaSource->getBasePath() . $internalPath;
            if (!$this->mediaSource->createContainer($internalPath, '')) {
                $this->modx->log(1, '[LoadToSelectel] Can`t create directory: ' . $path);
                continue;
            }

            foreach ($keys as $key) {
                $files = [];
                if (!$fileInfo = $this->uploadFiles($filesData[$key], $internalPath)) {
                    $this->setModerateLog([
                        'user_id' => 1,
                        'rid' => (int)$product->get('id'),
                        'msg' => $key === 'print' ? 'Не удалось загрузить файлы для печати в облако.' : 'Не удалось загрузить файлы превью в облако.',
                        'place' => '\CustomServices\LoadToSelectel',
                        'method' => 'prepareLoading',
                        'productData' => $product->toArray()
                    ]);
                    continue;
                }

                foreach ($fileInfo as $info) {
                    $files[] = $info['path'];
                }

                if (!empty($files)) {
                    $product->set($key, implode('|', $files));
                    $workflow[$key] = implode('|', $files);
                    $flag++;

                    $this->setModerateLog([
                        'user_id' => 1,
                        'rid' => (int)$product->get('id'),
                        'msg' => $key === 'print' ? 'Файлы для печати загружены в облако.' : 'Файлы превью загружены в облако.',
                        'place' => '\CustomServices\LoadToSelectel',
                        'method' => 'prepareLoading',
                        'productData' => $product->toArray()
                    ]);
                }
            }

            if ($flag === 2) {
                foreach ($keys as $key) {
                    $this->removeFiles($filesData[$key]);
                    $this->removeEmptyDir(dirname($filesData[$key][0]['tmp_name']));
                }

                if ($prevStatus === 7) {
                    $workflow['designer_date'] = date('Y-m-d H:i:s');
                    $workflow['designer_comment'] = $product->get('introtext');
                    $product->set('prev_status', 0);
                    $this->setWorkflow($workflow, $product);
                    $this->setModerateLog([
                        'user_id' => 1,
                        'rid' => (int)$product->get('id'),
                        'msg' => 'Добавлен элемент workflow.',
                        'place' => '\CustomServices\LoadToSelectel',
                        'method' => 'prepareLoading',
                        'productData' => $workflow
                    ]);
                }
                $product->set('status', $status);
                $product->set('published', 1);
                $product->set('temp_files', '');
                $product->save();
                $this->flatfilters->indexingDocument($product);
                $this->setModerateLog([
                    'user_id' => 1,
                    'rid' => (int)$product->get('id'),
                    'msg' => 'Завершена загрузка файлов в облако.',
                    'place' => '\CustomServices\LoadToSelectel',
                    'method' => 'prepareLoading',
                    'productData' => $product->toArray()
                ]);
            } else {
                $this->setModerateLog([
                    'user_id' => 1,
                    'rid' => (int)$product->get('id'),
                    'msg' => 'Что-то пошло не так при загрузке файлов в облако.',
                    'place' => '\CustomServices\LoadToSelectel',
                    'method' => 'prepareLoading',
                    'productData' => $product->toArray()
                ]);
            }
        }
    }

    /**
     * @param string $path
     * @return array|string|string[]
     */
    private function preparePath(string $path)
    {
        $search = array('{year}', '{month}', '{day}', '{time}');
        $replace = array(date('Y'), date('m'), date('d'), date('H-i-s'));

        return str_replace($search, $replace, $path);
    }

    /**
     * @param array $filelist
     * @return array
     */
    private function getProductFiles(array $filelist): array
    {
        $prints = [];
        $previews = [];
        $basePath = $this->basePath;
        /*if(strpos($this->basePath,'art-sites') === false && $this->mediaSource->get('id') === 3){
            $basePath = '/jail/' . $this->basePath;
        }*/

        foreach ($filelist as $item) {
            $preview = $this->modx->runSnippet('pThumb', [
                'input' => $basePath . $item,
                'options' => 'w=249&h=281&zc=1&q=60'
            ]);
            if ($preview === $item) {
                $this->modx->log(1, '[LoadToSelectel::getProductFiles] Не удалось сгенерировать превью');
                return [];
            }

            if ($itemData = $this->getFileData($this->basePath . $item)) {
                $prints[] = $itemData;
            }
            if (strpos($preview, $this->basePath) !== 0) {
                $preview = $this->basePath . preg_replace('/^\//', '', $preview);
            }
            if ($previewData = $this->getFileData($preview)) {
                $previews[] = $previewData;
            }
        }
        if (empty($prints)) {
            return [];
        }
        return [
            'print' => $prints,
            'preview' => $previews,
        ];
    }

    /**
     * @param array $filelist
     * @return array
     */
    private function getProductPreviews(array $filelist): array
    {
        $previews = [];
        $source = $this->mediaSource->toArray();
        $basePath = $source['properties']['url']['value'];

        foreach ($filelist as $item) {
            $preview = $this->modx->runSnippet('pThumb', [
                'input' => $basePath . $item,
                'options' => 'w=249&h=281&zc=1&q=60'
            ]);

            if ($preview === $basePath . $item) {
                $this->modx->log(1, '[LoadToSelectel::getProductPreviews] Не удалось сгенерировать превью');
                return [];
            }

            if (strpos($preview, $this->basePath) !== 0) {
                $preview = $this->basePath . preg_replace('/^\//', '', $preview);
            }
            if ($previewData = $this->getFileData($preview)) {
                $previews[] = $previewData;
            }
        }

        return $previews;
    }

    /**
     * @param string $fullPath
     * @return array
     */
    private function getFileData(string $fullPath)
    {
        if (!file_exists($fullPath)) {
            $this->modx->log(1, '[LoadToSelectel::getFileData] Файл не существует: ' . $fullPath);
            return [];
        }
        return [
            'name' => basename($fullPath),
            'tmp_name' => $fullPath,
            'size' => filesize($fullPath),
        ];
    }

    /**
     * @param array $files
     * @param string $internalPath
     * @return array|bool
     */
    private function uploadFiles(array $files, string $internalPath)
    {
        if (empty($files)) {
            return false;
        }

        $filesInfo = [];
        $count = 0;
        $size = 0;

        foreach ($files as $file) {
            $originalFilename = $file['name'];
            $ext = strtolower(pathinfo($originalFilename, PATHINFO_EXTENSION));

            $filename = $this->modx->filterPathSegment($this->generateRandomName()) . "." . $ext;

            $uploadResult = $this->mediaSource->uploadObjectsToContainer(
                $internalPath,
                [array_merge($file, ['name' => $filename])]
            );

            if ($uploadResult) {
                $filesInfo[] = array(
                    'name' => $filename,
                    'name_original' => $originalFilename,
                    'path' => $internalPath . $filename,
                    'url' => $this->mediaSource->getObjectUrl($internalPath . $filename),
                    'size' => $file['size'],
                    'extension' => $ext
                );
                $count++;
                $size += $file['size'];
            } else {
                $errorMessage = '';
                $errors = $this->mediaSource->getErrors();
                foreach ($errors as $k => $msg) {
                    $errorMessage .= $k . ': ' . $msg . '. ';
                }
                $this->modx->log(1, print_r($internalPath, 1));
                $this->modx->log(1, '[LoadToSelectel] Can`t upload user file: ' . $originalFilename . '. Error text: ' . $errorMessage);
                return [];
            }
        }
        return $filesInfo;
    }

    /**
     * Генерирует случайное имя для файла
     * @param int $length
     * @return string
     */
    private function generateRandomName($length = 16): string
    {
        $characters = '0123456789abcdefghijklmnopqrstuvwxyz_';
        $charactersLength = strlen($characters);

        $result = '';

        for ($i = 0; $i < $length; $i++) {
            $result .= $characters[rand(0, $charactersLength - 1)];
        }

        return $result;
    }

    /**
     * @param array $files
     * @return void
     */
    private function removeFiles(array $files)
    {
        foreach ($files as $file) {
            if (file_exists($file['tmp_name'])) {
                unlink($file['tmp_name']);
            }
        }
    }

    /**
     * @param string $dir
     * @return void
     */
    private function removeEmptyDir(string $dir): void
    {
        if(!file_exists($dir)){
            return;
        }
        if (strpos($dir, '/assets/') === false) {
            return;
        }
        if ($objs = glob($dir . '/*')) {
            foreach ($objs as $obj) {
                if (is_dir($obj)) {
                    $this->removeEmptyDir($obj);
                }
            }
        }
        if (count(scandir($dir)) == 2) {
            rmdir($dir);
        }
    }

    /**
     * @param $path
     * @return bool
     */
    public function removeContainer($path): bool
    {
        if (!$this->mediaSource) {
            $this->modx->log(1, '[LoadToSelectel::initialize] Не удалось получить медиа источник.');
            return false;
        }
        $path = $this->mediaSource->getBasePath() . $path;

        $this->mediaSource->removeContainer($path);
        return true;
    }
}
