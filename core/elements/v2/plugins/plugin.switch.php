<?php

use CustomServices\Designer;
use CustomServices\Product;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

switch ($modx->event->name) {
    case 'OnGetFormParams':
        if($presetName === 'upload_excel'){
            $_SESSION['selectedIds'] = [];
        }
        break;
    case 'OnBeforeReturnResponse':
        if ($_POST['email'] && in_array($presetName, ['auth', 'register'])) {
            $user = $modx->getObject('modUser', ['username' => $_POST['email']]);
            if ($user && !$user->isMember('Designers')) {
                $response['data']['redirectUrl'] = $modx->makeUrl(54750, '', '', 'full');
                $modx->event->returnedValues['response'] = $response;
            }
        }
        break;
    case 'OnLoadWebDocument':
        $designerService = new Designer($modx);
        $designerService->getProgress($modx->user->get('id'));
        $cacheKey = 'offerPageKey::cache';
        if (!$offerPageKey = $modx->cacheManager->get($cacheKey)) {
            if ($offerResource = $modx->getObject('modResource', 51976)) {
                $offerPageKey = 'offer' . $offerResource->get('introtext');
                $modx->cacheManager->set($cacheKey, $offerPageKey, 10800);
            }
        }
        break;

    case 'OnBeforeDocFormSave':
        $designerService = new Designer($modx);
        $designerService->prepareUpdateOffer($resource);
        break;

    case 'OnDocFormSave':
        $designerService = new Designer($modx);
        $designerService->updateOffer($resource);
        break;

    case 'OnBeforeFileValidate':
        $values = &$modx->event->returnedValues;
        //$modx->log(1, print_r($params, 1));
        break;

    case 'ffOnBeforeFilter':
        if (in_array($configData['id'], [1, 2, 4]) && $_REQUEST['query']) {
            $FlatFilters->values['query'] = $_REQUEST['query'];
        }
        break;
    case 'ffOnBeforeSetFilterConditions':
        if ($modx->user->isMember(['Designers'])) {
            foreach($conditions as $k => $condition){
                if(strpos($condition, ':createdby') !== false){
                    $conditions[$k] = str_replace('>', '=', $condition);
                    $FlatFilters->tokens['createdby'] = $modx->user->get('id');
                }
            }
        }
        $modx->event->returnedValues['conditions'] = $conditions;
        break;
    case 'ffOnBeforeGetFilterValues':
        if ($modx->user->isMember(['Designers'])) {
            foreach($conditions as $k => $condition){
                if(strpos($condition, ':createdby') !== false){
                    $conditions[$k] = str_replace('>', '=', $condition);
                    $FlatFilters->tokens['createdby'] = $modx->user->get('id');
                }
            }
        }
        $modx->event->returnedValues['conditions'] = $conditions;
        break;
    case 'ffOnAfterGetFilterValues':
        if ($configData['id'] === 2) {
            foreach($output as $key => $item){
                if(in_array($key, ['color', 'tags'])){
                    $array = $item['values'];
                    $k = array_search("не задан", $array);
                    if ($k !== false) {
                        unset($array[$k]);
                        array_unshift($array, "не задан");
                        $output[$key]['values'] = $array;
                    }
                }

                if($key === 'root_id'){
                    $q = $modx->newQuery('modResource');
                    $q->where(['id:IN' => $item['values'], 'class_key' => 'msProduct']);
                    $q->select('parent, id');
                    if($q->prepare() && $q->stmt->execute()){
                        $products = $q->stmt->fetchAll(PDO::FETCH_ASSOC);
                        $values = [];
                        $grouped = [];
                        foreach($products as $product){
                            $grouped[$product['parent']][] = $product['id'];
                        }
                        foreach($grouped as $ids){
                            $values = array_merge($values, $ids);
                        }
                        $output[$key]['values'] = $values;
                    }
                }
            }
        }
        $modx->event->returnedValues['output'] = $output;
        break;
    case 'ffOnAfterFilter':
        if ($_REQUEST['query']) {
            switch ($configData['id']) {
                case 1:
                    $designerService = new Designer($modx);
                    $designerService->searchUsers($_REQUEST['query'], $rids, $configData['id']);
                    break;
                case 2:
                case 4:
                    $productService = new Product($modx);
                    $productService->searchProducts($_REQUEST['query'], $rids, $configData['id']);
                    break;
            }
        }
        break;

    case 'ffOnBeforeRender':
        $pdoTools = $modx->getParser()->pdoTools;
        $cacheKey = 'offerPageKey::cache';
        if (!$offerPageKey = $modx->cacheManager->get($cacheKey)) {
            if ($offerResource = $modx->getObject('modResource', 51976)) {
                $offerPageKey = 'offer' . $offerResource->get('introtext');
                $modx->cacheManager->set($cacheKey, $offerPageKey, 10800);
            }
        }
        $statuses = $pdoTools->runSnippet('@FILE snippets/base/snippet.getstatuses.php', []);
        $modx->event->returnedValues['props'] = array_merge($props, ['statuses' => $statuses, 'offerPageKey' => $offerPageKey]);
        break;
    case 'ffOnBeforeSetIndexValue':
        if (in_array($key, ['color', 'tags'])) {
            $modx->event->returnedValues['value'] = $value ?: 'не задан';
        }
        break;
    case 'ffOnGetFieldKeys':
        if ($type === 'statistic') {
            $modx->event->returnedValues = array_merge(
                $FlatFilters->getTableKeys('site_content'),
                $FlatFilters->getTableKeys('ms2_products'),
                $FlatFilters->getTableKeys('salesstatistics_items')
            );
        }
        break;

    case 'OnResourceDelete':
        if($product = $modx->getObject('msProduct', $id)){
            $product->set('delete_at', date('d.m.Y', strtotime('+7 days')));
            $product->save();
        }
        break;

    case 'OnResourceUndelete':
        if($product = $modx->getObject('msProduct', $id)){
            $product->set('delete_at', '');
            $product->save();
        }
        break;

    case 'OnWebLogin':
        unset($_SESSION['flatfilters']);
        break;
}
