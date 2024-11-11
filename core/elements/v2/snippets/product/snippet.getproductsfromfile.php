<?php

use CustomServices\Product;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

$productService = new Product($modx);
if(empty($_REQUEST['filelist'])){
    return $SendIt->error('Не удалось найти файл.');
}
$filelist = explode(',', $_REQUEST['filelist']);
$result = $productService->getProductsFromFile($filelist[0], (int)$_REQUEST['page']?:1, (int)$_REQUEST['limit']?:30);
if($result['success']){
    return $SendIt->success($result['msg'], $result);
}
return $SendIt->error($result['msg']);
