<?php

use CustomServices\Product;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

$productService = new Product($modx);
$resources = explode(',', $_SESSION['flatfilters'][4]['rids']);
$result = $productService->getStatistic($resources, 'total_');
if(!empty($result['total'])) {
    return $SendIt->success('', ['total' => $result['total']]);
}
return $SendIt->error('');
