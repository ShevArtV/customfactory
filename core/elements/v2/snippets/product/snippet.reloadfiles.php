<?php

use CustomServices\Product;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

$data = json_decode($_POST['data'], true);
$filelist = isset($_POST['filelist']) ? explode(',', $_POST['filelist']) : [];
$modx->log(1, print_r($data, 1));
$modx->log(1, print_r($filelist, 1));
if($_POST['maxcount'] <= 0 || count($filelist) <= 0 || count($filelist) !== (int)$_POST['maxcount']){
    return $SendIt->error('Вы загрузили недостаточное количество файлов.');
}

$productService = new Product($modx);
$result = $productService->updateProduct($data);
if($result['success']){
    $productService->prepareFiles($filelist, $result['rid']);
    return $SendIt->success('Дизайн отправлен на модерацию.');
}
return $SendIt->error($result['msg']);