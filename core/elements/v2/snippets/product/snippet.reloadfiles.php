<?php

use CustomServices\Product;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

$data = json_decode($_POST['data'], true);
$filelist = $_POST['filelist'] ? explode(',', $_POST['filelist']) : [];
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