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
            if (!$data['active']) {
                continue;
            }
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
            if ($data['colors']) {
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
        $profiles = $modx->getIterator('modUserProfile');
        foreach ($profiles as $profile) {
            $user_id = $profile->get('internalKey');
            $old_id = $profile->get('old_id');
            //$sql = "UPDATE `cust_ms2_orders` SET `user_id` = {$user_id}, `type` = 1 WHERE `user_id` = {$old_id} AND `type` = 0";
            $sql2 = "UPDATE `cust_ms2_order_addresses` SET `user_id` = {$user_id}, `comment` = 1  WHERE `user_id` = {$old_id} AND `comment` != 1";
            //$modx->query($sql);
            $modx->query($sql2);
        }
        //$countOrders = $modx->getCount('msOrder', ['type' => 0]);
        $countAddresses = $modx->getCount('msOrderAddress', ['comment:!=' => 1]);

        //$modx->log(1, print_r($countOrders, 1));
        $modx->log(1, print_r($countAddresses, 1));

        //UPDATE modx_ms2_order_addresses SET order_id = id;
        break;

    case 'order_products':
        $products = $modx->getIterator('msProduct');
        foreach ($products as $product) {
            $old_id =$product->get('old_id');
            $id = $product->get('id');
            $sql = "UPDATE `cust_ms2_order_products` SET `product_id` = {$id}, `weight` = 1 WHERE `product_id` = {$old_id} AND `weight` = 0";
            $modx->query($sql);
        }
        break;

    case 'product_templates':
        $filename = 'product_templates.json';
        $data = json_decode(file_get_contents(MODX_CORE_PATH . 'elements/v2/import/' . $filename), 1);

        foreach ($data as $item) {
            $config = json_decode($item['tvs']['config'], true);
            $newConfig = [];
            if (!is_array($config)) {
                continue;
            }
            foreach ($config as $c) {
                if (isset($c['list_with_img'])) {
                    $images = json_decode($c['list_with_img'], 1);
                    $list_simple_img = [];
                    foreach ($images as $i) {
                        $list_simple_img[] = [
                            'MIGX_id' => $i['MIGX_id'],
                            'img' => str_replace('assets/project_files/img/', 'assets/project_files/v2/img/', $i['img']),
                            'img_w' => '',
                            'img_h' => '',
                        ];
                    }
                    $c['list_simple_img'] = json_encode($list_simple_img);
                    unset($c['list_with_img']);
                }
                switch ($c['MIGX_formname']) {
                    case 'popular_products':
                    case 'product_card':
                        $newConfig[] = [
                            'MIGX_id' => $c['MIGX_id'],
                            'MIGX_formname' => $c['MIGX_formname'],
                            'id' => $c['id'],
                            'section_name' => $c['section_name'],
                            'file_name' => $c['file_name'],
                            'is_static' => false,
                        ];
                        break;
                    case 'design_examples':
                        $newConfig[] = [
                            'MIGX_id' => $c['MIGX_id'],
                            'MIGX_formname' => $c['MIGX_formname'],
                            'id' => $c['id'],
                            'section_name' => $c['section_name'],
                            'file_name' => $c['file_name'],
                            'is_static' => false,
                            'title' => $c['title'],
                            'subtitle' => $c['subtitle'],
                            'list_simple_img' => $c['list_simple_img'],
                        ];
                        break;
                    case 'technical_demands':
                        $newConfig[] = [
                            'MIGX_id' => $c['MIGX_id'],
                            'MIGX_formname' => $c['MIGX_formname'],
                            'id' => $c['id'],
                            'section_name' => $c['section_name'],
                            'file_name' => $c['file_name'],
                            'is_static' => false,
                            'title' => $c['title'],
                            'list_double' => $c['list_double'],
                        ];
                        break;
                }
            }
            if ($product = $modx->getObject('modResource', ['old_id' => $item['id']])) {
                $product->setTVValue('config', json_encode($newConfig));
                $product->setTVValue('img', str_replace('assets/project_files/img/', 'assets/project_files/v2/img/', $item['tvs']['img']));
                $product->setTVValue('tplfile', str_replace('assets/project_files/img/', 'assets/project_files/v2/img/', $item['tvs']['tplfile']));
                $product->set('template', 14);
                $product->save();
                $modx->log(1, print_r($newConfig, 1));
            }
        }
        break;
}
echo 'Import Finished from ' . $filename . PHP_EOL;