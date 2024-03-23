<?php

use CustomServices\Designer;
use CustomServices\Product;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

switch ($modx->event->name) {
    case 'OnBeforeReturnResponse':
        if($_POST['email'] && in_array($presetName, ['auth', 'register'])){
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
        if (in_array($configData['id'], [1, 2]) && $_REQUEST['query']) {
            $FlatFilters->values['query'] = $_REQUEST['query'];
        }
        break;
    case 'ffOnBeforeSetFilterConditions':
        if ($modx->user->isMember(['Designers'])) {
            $conditions[] = '`createdby` = ' . $modx->user->get('id');
        }
        if ($configData['id'] === 2 && $modx->user->isMember(['Moderators', 'Managers'])) {
            $conditions[] = '`status` != 7';
        }
        $modx->event->returnedValues['conditions'] = $conditions;
        break;
    case 'ffOnAfterFilter':
        if ($_REQUEST['query']) {
            switch ($configData['id']) {
                case 1:
                    $designerService = new Designer($modx);
                    $designerService->searchUsers($_REQUEST['query'], $rids, $configData['id']);
                    break;
                case 2:
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
}