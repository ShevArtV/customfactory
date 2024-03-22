<?php

use CustomServices\Product;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

$productService = new Product($modx);

$result = $productService->getDefaultProducts($_POST);
if(!$SendIt){
    return $result;
}
return $SendIt->success('', ['html' => $result]);