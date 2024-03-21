<?php

use CustomServices\Product;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

$productService = new Product($modx);

$result = $productService->loadWorkflow($_POST['rid']);
if($result['success']){
    return $SendIt->success($result['msg'], ['html' => $result['html']]);
}
return $SendIt->error($result['msg']);