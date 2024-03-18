<?php
use CustomServices\Designer;
use CustomServices\Product;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

switch ($modx->event->name) {
    case 'OnLoadWebDocument':
        $designerService = new Designer($modx);
        $designerService->getProgress($modx->user->get('id'));
        if ($modx->resource->template === 18) {
            if ($offerResource = $modx->getObject('modResource', 51976)) {
                $modx->setPlaceholder('offerPageKey', 'offer' . $offerResource->get('introtext'));
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
        if (in_array($configData['id'], [1,2]) && $_REQUEST['query']) {
            $FlatFilters->values['query'] = $_REQUEST['query'];
        }
        break;
    case 'ffOnAfterFilter':
        if($_REQUEST['query']){
            switch ($configData['id']){
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
        $modx->setPlaceholder('statuses', $modx->getParser()->pdoTools->runSnippet('@FILE snippets/base/snippet.getstatuses.php', []));
        if ($offerResource = $modx->getObject('modResource', 51976)) {
            $modx->setPlaceholder('offerPageKey', 'offer' . $offerResource->get('introtext'));
        }
        break;
    case 'ffOnBeforeSetIndexValue':
        if(in_array($key, ['color', 'tags'])){
            $modx->event->returnedValues['value'] = $value ?: 'не задан';
        }
        break;
}