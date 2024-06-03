<?php

use CustomServices\Product;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

$productService = new Product($modx);
$filelist = $_POST['filelist'] ? explode(',', $_POST['filelist']) : [];
$ids = json_decode($_POST['selected_id'],true);
if(!empty($filelist)){
    $productService->prepareFiles($filelist, (int)$ids[0], 'screenshots/');
}
$result = $productService->updateProduct(['status' => $_POST['status'], 'id' => (int)$ids[0], 'content' => $_POST['content']]);
if($result['success']){
    return $SendIt->success($result['msg'], $result);
}
return $SendIt->error($result['msg'], $result);