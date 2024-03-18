<?php

use CustomServices\Product;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

$productService = new Product($modx);
$prohibited_categories = $prohibited_categories?:'9999999999';
return $productService->getDesignTemplates($prohibited_categories);