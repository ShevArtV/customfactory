<?php
// /usr/local/php/php-7.4/bin/php -d display_errors -d error_reporting=E_ALL /home/host1860015/art-sites.ru/htdocs/customfactory/core/elements/v2/console/import.php
// Импорт делал 22.02.2024

define('MODX_API_MODE', true);
require_once dirname(__FILE__, 5) . '/index.php';

$modx->getService('error', 'error.modError');
$modx->setLogLevel(modX::LOG_LEVEL_ERROR);
/*$products = $modx->getIterator('msProduct');
foreach($products as $product){
    if($product->get('createdby') === 1){
        $product->set('template', 14);
    }else{
        $product->set('template', 13);
    }
    $product->save();
    unset($product);
}*/
$filename = '';
switch ($argv[1]) {
    case 'users':
        // import users
        $filename = 'users.json';
        $userData = json_decode(file_get_contents(MODX_CORE_PATH . 'elements/v2/import/' . $filename), 1);
        foreach ($userData as $data) {
            if (!$data['active']) continue;
            $profileData = $data['profile'];
            $profileData['old_id'] = (int)$data['id'];
            unset($data['id'], $data['profile'], $profileData['id'], $profileData['internalKey']);
            $groups = [];
            if ($user = $modx->getObject('modUser', ['username' => $data['username']])) {
                $profile = $user->getOne('Profile');
                $user->fromArray($data, '', true);
                $profile->fromArray($profileData, '', true);
                if (!$modx->getCount('modUserGroupMember', ['user_group' => $data['primary_group'], 'member' => $user->get('id')])) {
                    $groupMember = $modx->newObject('modUserGroupMember');
                    $groupMember->set('user_group', $data['primary_group']);
                    $groupMember->set('role', 1); //
                    $groups[] = $groupMember;
                    $user->addMany($groups);
                }
            } else {
                $user = $modx->newObject('modUser');
                $profile = $modx->newObject('modUserProfile');
                $groupMember = $modx->newObject('modUserGroupMember');
                $groupMember->set('user_group', $data['primary_group']);
                $groupMember->set('role', 1); //
                $groups[] = $groupMember;
                $user->fromArray($data, '', true);
                $profile->fromArray($profileData, '', true);
                $user->addOne($profile);
                $user->addMany($groups);
            }

            $profile->save();
            $user->save();
        }
        break;
    case 'products':
        // import products
        $arr = [
            0 => ['old' => 17, 'new' => 14, 'name' => 'pillows.json'],
            1 => ['old' => 18, 'new' => 15, 'name' => 'pictures.json'],
            2 => ['old' => 5500, 'new' => 16, 'name' => 'roads.json'],
            3 => ['old' => 16, 'new' => 17, 'name' => 'wallpapers.json'],
            4 => ['old' => 90, 'new' => 18, 'name' => 'posters.json'],
            5 => ['old' => 19, 'new' => 19, 'name' => 'bags.json'],
            6 => ['old' => 50227, 'new' => 20, 'name' => 'promos.json'],
        ];
        $filename = '1promos.json';
        $productData = json_decode(file_get_contents(MODX_CORE_PATH . 'elements/v2/import/' . $filename), 1);

        foreach ($productData as $data) {
            $data['old_id'] = $data['id'];
            $data['template'] = 14;
            unset($data['id']);
            if (!$product = $modx->getObject('msProduct', ['pagetitle' => $data['pagetitle']])) {
                $product = $modx->newObject('msProduct');
            }
            if ($data['createdby'] !== 1) {
                $data['template'] = 13;
                if ($user = $modx->getObject('modUser', ['username' => $data['createdby']])) {
                    $profile = $user->getOne('Profile');
                    $data['createdby'] = $user->get('id');
                    $data['designer'] = $profile->get('fullname');
                    unset($user, $profile);
                } else {
                    $data['createdby'] = 3215;
                    $data['designer'] = 'unknown';
                }
            }
            if($data['colors']){
                $data['color'] = explode(';', $data['colors']);
                unset($data['colors']);
            }

            $product->fromArray($data, '', true);
            $product->save();
            unset($product);
        }
        break;
    case 'tags':
        $corePath = $modx->getOption('tagger.core_path', null, $modx->getOption('core_path', null, MODX_CORE_PATH) . 'components/tagger/');
        /** @var Tagger $tagger */
        $tagger = $modx->getService(
            'tagger',
            'Tagger',
            $corePath . 'model/tagger/',
            array(
                'core_path' => $corePath
            )
        );
        $filename = 'tags5.json';
        $tagsData = json_decode(file_get_contents(MODX_CORE_PATH . 'elements/v2/import/' . $filename), 1);
        //echo count($tagsData);
        $count = count($tagsData);
        $i = $prevpercent = 0;
        foreach ($tagsData as $data) {
            if ($resource = $modx->getObject('modResource', ['pagetitle' => $data['pagetitle']])) {
                $data['resource'] = $resource->get('id');
                unset($data['pagetitle']);
                if (!$modx->getCount('TaggerTagResource', $data)) {
                    $tag = $modx->newObject('TaggerTagResource');
                    $tag->fromArray($data, '', true);
                    $tag->save();
                    unset($resource, $tag);
                }
            } else {
                //$modx->log(1, $data['pagetitle']);
                echo $data['pagetitle'] . PHP_EOL;
            }
            $i++;
            $present = round($i / $count, 2) * 100;
            if ($prevpercent !== $present) {
                $modx->log(1, 'Обработано: ' . $present . '%');
                $prevpercent = $present;
            }
        }
        break;

    case 'orders':
        $orders = $modx->getIterator('msOrder');
        foreach ($orders as $order) {
            if (!$profile = $modx->getObject('modUserProfile', ['old_id' => $order->get('user_id')])) {
                continue;
            }
            $address = $modx->getObject('msOrderAddress', $order->get('id'));
            $order->set('user_id', $profile->get('internalKey'));
            $address->set('user_id', $profile->get('internalKey'));
            $address->set('order_id', $order->get('id'));
            $order->save();
            $address->save();
        }
        break;

    case 'order_products':
        $orderProducts = $modx->getIterator('msOrderProduct');
        foreach ($orderProducts as $orderProduct) {
            if (!$product = $modx->getObject('msProduct', ['old_id' => $orderProduct->get('product_id')])) {
                continue;
            }
            $orderProduct->set('product_id', $product->get('id'));
            $orderProduct->save();
        }
        break;
}
echo 'Import Finished from ' . $filename . PHP_EOL;