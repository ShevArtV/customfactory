<?php

namespace CustomServices;

/**
 *
 */
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
        if (!$parentsData = $this->getParents()) {
            $this->modx->log(1, '[LoadToSelectel::initialize] Не удалось получить список родителей.');
            return false;
        }
        $parents = [];
        foreach($parentsData as $data){
            $parents[] = $data['id'];
        }

        $products = $this->getNewProducts($parents);
        $this->prepareLoading($products);
        return true;
    }

    /**
     * @param array $parents
     * @return \xPDOIterator
     */
    private function getNewProducts(array $parents): \xPDOIterator
    {
        $q = $this->modx->newQuery('modResource');
        $q->leftJoin('msProductData', 'msProductData', 'modResource.id = msProductData.id');
        $q->where([
            'msProductData.status' => 0,
            'modResource.parent:IN' => $parents,
            'modResource.class_key' => 'msProduct',
            'modResource.template' => 13
        ]);

        return $this->modx->getIterator('modResource', $q);
    }

    /**
     * @param \xPDOIterator $products
     * @return void
     */
    private function prepareLoading(\xPDOIterator $products): void
    {
        foreach ($products as $product) {
            $filelist = $product->get('temp_files');
            $flag = 0;
            if (empty($filelist)) {
                $product->remove();
                continue;
            }

            $rid = $product->get('id');
            $createdby = $product->get('createdby');
            $keys = ['print', 'preview'];
            $internalPath = $this->preparePath($createdby . '/' . $rid . '/{day}-{month}-{year}-{time}/');
            if (!$filesData = $this->getProductFiles(explode('|', $filelist))) {
                continue;
            }

            foreach ($keys as $key) {
                $files = [];
                if (!$fileInfo = $this->uploadFiles($filesData[$key], $internalPath)) {
                    continue;
                }

                foreach ($fileInfo as $info) {
                    $files[] = $info['path'];
                }

                if (!empty($files)) {
                    $product->set($key, implode('|', $files));
                    $this->removeFiles($filesData[$key]);
                    $this->removeEmptyDir(dirname($filesData[$key][0]['tmp_name']));
                    $flag++;
                }
            }

            if($flag === 2){
                $status = $product->get('status') ?: 1;
                $product->set('status', $status);
                $product->set('published', 1);
                $product->set('temp_files', '');
                $product->save();
                $this->flatfilters->indexingDocument($product);
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
     * @param array $product
     * @return array
     */
    private function getProductFiles(array $filelist): array
    {
        $prints = [];
        $previews = [];

        foreach ($filelist as $item) {
            $preview = $this->modx->runSnippet('pThumb', [
                'input' => $item,
                'options' => 'w=249&h=281&zc=1&q=60'
            ]);
            $prints[] = $this->getFileData($this->basePath . $item);
            $previews[] = $this->getFileData($this->basePath . preg_replace('/^\//', '', $preview));
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
     * @param string $fullPath
     * @return array
     */
    private function getFileData(string $fullPath)
    {
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

        $internalPath = $this->preparePath($internalPath);
        $path = $this->mediaSource->getBasePath() . $internalPath;

        if (!$this->mediaSource->createContainer($internalPath, '')) {
            $this->modx->log(1, '[LoadToSelectel] Can`t create directory: ' . $path);
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