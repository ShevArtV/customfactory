<?php

use CustomServices\LoadToSelectel;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

if(!$id = (int)$_POST['id']){
    return $SendIt->error('Не указан ID товара.');
}

$q = $modx->newQuery('msProductData');
$q->where(['id' => $id, 'preview:!=' => '']);
if(!$productData = $modx->getObject('msProductData', $q)){
    $q->prepare();
    $modx->log(1, print_r(['sql' => $q->toSQL()], 1));
    return $SendIt->error('Не удалось получить данные.');
}

if(!$previews = $productData->get('preview')){
    return $SendIt->success('Превью будут сгенерированы заново!');
}
$previews = explode('|', $previews);
$LoadToSelectel = new LoadToSelectel($modx);
foreach($previews as $preview){
    $LoadToSelectel->removeObject($preview);
}
$productData->set('preview', '');
$productData->save();

return $SendIt->success('Превью будут сгенерированы заново!');
