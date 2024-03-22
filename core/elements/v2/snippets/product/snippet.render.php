<?php

use CustomServices\Product;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

$productService = new Product($modx);

$result = $productService->renderProducts($scriptProperties);

return $result['html'];