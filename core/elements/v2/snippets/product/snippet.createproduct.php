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
$parent = (int)$_POST['parent'];
$success = false;
$filelist = $_POST['filelist'] ? explode(',', $_POST['filelist']) : [];
if ($data['count_files'] <= 0 || count($filelist) <= 0 || count($filelist) !== (int)$data['count_files']) {
    return $SendIt->error('Вы загрузили недостаточное количество файлов.');
}
$productService = new Product($modx);
if (in_array($parent, [19, 54754])) {
    $where = [
        'modResource.parent' => $parent,
        'Data.cut:IN' => $data['cut'],
        'Data.gender:IN' => $data['gender'],
        'Data.root_id' => $data['root_id'],
    ];
    $variations = $productService->getProductVariations($where);
    if (empty($variations)) {
        return $SendIt->error('Не удалось получить вариации.');
    }
    $i = 0;
    $modx->log(1, print_r($variations, 1));
    foreach ($variations as $rootId => $variation) {
        $i++;
        $isCopy = count($variations) !== $i;
        $result = $productService->createProduct(array_merge($data, [
            'root_id' => $rootId,
            'cut' => $variation[0]['cut'],
            'gender' => $variation[0]['gender'],
        ]));
        if ($result['success']) {
            $productService->prepareFiles($filelist, $result['rid'], $folder = 'loadtoselectel/', $field = 'temp_files', $isCopy);
            $success = true;
        }
    }
} else {
    $result = $productService->createProduct($data);
    if ($result['success']) {
        $productService->prepareFiles($filelist, $result['rid']);
        $success = true;
    }
}

if ($success) {
    return $SendIt->success('Дизайн отправлен на модерацию.');
} else {
    return $SendIt->error('Не удалось отправить дизайн на модерацию.');
}
