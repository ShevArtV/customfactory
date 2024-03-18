<?php
use CustomServices\Designer;

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
        if ($configData['id'] === 1 && $_REQUEST['query']) {
            $FlatFilters->values['query'] = $_REQUEST['query'];
        }
        break;
    case 'ffOnAfterFilter':
        if ($configData['id'] === 1 && $_REQUEST['query']) {
            $phone = preg_replace('/[^0-9]/', '', $_GET['query']);
            $phone = preg_replace('/(\d)(\d{3})(\d{3})(\d{2})(\d{2})$/', '+7(\2)\3-\4-\5', $phone);
            $query = "%{$_REQUEST['query']}%";
            $rids =  explode(',', $rids);
            $params = array(
                ':query' => $query,
                ':phone' => $phone ?: $query,
                ':date' => strtotime($query) ? '%' . strtotime($query) . '%' : $query,
            );

            $q = $modx->newQuery('modUser');
            $q->leftJoin('modUserProfile', 'Profile');
            $q->select('modUser.id as id');
            $q->where("
                    (modUser.username LIKE :query 
                    OR Profile.fullname LIKE :query
                    OR Profile.profile_num LIKE :query
                    OR Profile.city LIKE :query 
                    OR Profile.email LIKE :query 
                    OR Profile.phone = :phone 
                    OR Profile.createdon LIKE :date 
                    OR Profile.pass_num LIKE :query 
                    OR Profile.pass_series LIKE :query
                    OR Profile.inn LIKE :query)                    
            ");
            $q->andCondition(['modUser.id:IN' => $rids]);
            $q->prepare($params);
            $tstart = microtime(true);
            if ($q->prepare() && $q->stmt->execute($params)) {
                $modx->queryTime += microtime(true) - $tstart;
                $modx->executedQueries++;
                $rids = $q->stmt->fetchAll(PDO::FETCH_COLUMN);
                $_SESSION['flatfilters'][$configData['id']]['totalResources'] = $q->stmt->rowCount();
            }

            $modx->event->returnedValues['rids'] = implode(',', $rids);
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