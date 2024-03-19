<?php

use CustomServices\Product;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

$productService = new Product($modx);
$method = $SendIt->presetName;
if (method_exists($productService, $method)) {
    $result = $productService->$method($_POST);
    if ($result['success']) {
        return $SendIt->success($result['msg'], $result);
    } else {
        return $SendIt->error($result['msg'], $result);
    }
}
return $SendIt->error("Метод не найден {$method}");