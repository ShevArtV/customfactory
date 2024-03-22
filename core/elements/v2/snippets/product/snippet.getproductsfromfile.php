<?php

use CustomServices\Product;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

$productService = new Product($modx);

if(empty($_POST['filelist'])){
    return $SendIt->error('Не удалось найти файл.');
}
$filelist = explode(',', $_POST['filelist']);
$result = $productService->getProductsFromFile($filelist[0], $_POST['page']);
if($result['success']){
    return $SendIt->success($result['msg'], $result);
}
return $SendIt->error($result['msg']);