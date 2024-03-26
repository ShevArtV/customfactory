<?php

use CustomServices\Product;
use CustomServices\Designer;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

$designerService = new Designer($modx);
$designerService->getProgress($modx->user->get('id'));
if ($modx->user->get('id') !== 1 && !$modx->getPlaceholder('user_allow_add')) {
    return $SendIt->error('Вам пока не доступна эта функция!');
}

$data = json_decode($_POST['data'], true);
$filelist = isset($_POST['filelist']) ? explode(',', $_POST['filelist']) : [];
if($data['count_files'] <= 0 || count($filelist) <= 0 || count($filelist) !== (int)$data['count_files']){
    return $SendIt->error('Вы загрузили недостаточное количество файлов.');
}

$productService = new Product($modx);
$result = $productService->createProduct($data);
if($result['success']){
    $productService->prepareFiles($filelist, $result['rid']);
    return $SendIt->success('Дизайн отправлен на модерацию.');
}
return $SendIt->error($result['msg']);
