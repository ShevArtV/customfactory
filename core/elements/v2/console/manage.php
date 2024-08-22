<?php

// /usr/local/php/php-7.4/bin/php -d display_errors -d error_reporting=E_ALL /home/host1860015/art-sites.ru/htdocs/customfactory/core/elements/v2/console/manage.php
// php7.4 www/core/elements/v2/console/manage.php sendemail
use CustomServices\Base;
use CustomServices\Statistic\StatisticBase;
use CustomServices\Statistic\StatisticOzon;
use CustomServices\Statistic\StatisticWb;
use CustomServices\LoadToSelectel;
use CustomServices\Product;

define('MODX_API_MODE', true);
require_once dirname(__FILE__, 5) . '/index.php';
require_once MODX_CORE_PATH . 'vendor/autoload.php';
$modx->getService('error', 'error.modError');
$modx->setLogLevel(modX::LOG_LEVEL_ERROR);
if (file_exists(MODX_CORE_PATH . 'cache/logs/error.log')) {
    unlink(MODX_CORE_PATH . 'cache/logs/error.log');
}

function execCURL($headers, $url, $method, $post_data, $ispost = false)
{
    global $modx;
    $curl = curl_init();
    $post_data = http_build_query($post_data);
    if ($ispost) {
        curl_setopt($curl, CURLOPT_POSTFIELDS, $post_data);
        curl_setopt($curl, CURLOPT_POST, true);
    }
    curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
    curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 20);
    curl_setopt($curl, CURLOPT_TIMEOUT, 60);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, 0);
    curl_setopt($curl, CURLOPT_URL, $url . $method);
    curl_setopt($curl, CURLOPT_FOLLOWLOCATION, 1);

    /*$info = curl_getinfo($curl);
    $error = curl_error($curl);
    $modx->log(1, print_r($error, 1));
    $modx->log(1, print_r($info, 1));*/

    return json_decode(curl_exec($curl), 1) ?? [];
}

function getDatabyApi($data, $method)
{
    global $modx;
    $result = execCURL([], 'http://s29784.h8.modhost.pro/assets/project_files/api.php', '', $data, 1);
    if (!$result['finished'] && $result['data']) {
        $modx->log(1, print_r($method . '::' . $data['offset'], 1));
        $method($result);
        $data['offset'] = $result['offset'];
        unset($result);
        getDatabyApi($data, $method);
    }
    unset($data, $result);
}

function importOrders($result)
{
    global $modx;
    $data = $result['data'];
    foreach ($data as $row) {
        $addressData = $row['address'];
        unset($addressData['id']);
        $productsData = $row['products'];
        unset($row['id'], $row['address'], $row['products']);

        if (!$order = $modx->getObject('msOrder', ['order_comment' => $row['order_comment']])) {
            $order = $modx->newObject('msOrder');
            $products = [];
            foreach ($productsData as $productData) {
                $product = $modx->newObject('msOrderProduct');
                if ($p = $modx->getObject('modResource', ['old_id' => $productData['product_id']])) {
                    $productData['product_id'] = $p->get('id');
                } else {
                    $productData['product_id'] = 1;
                }
                $product->fromArray($productData);
                $products[] = $product;
            }
            $order->addMany($products);
            $address = $modx->newObject('msOrderAddress');
        } else {
            $address = $order->getOne('Address');
        }


        if ($profile = $modx->getObject('modUserProfile', [
            'old_id' => $row['user_id'],
        ])) {
            $row['user_id'] = $addressData['user_id'] = $profile->get('internalKey');
        } else {
            $row['user_id'] = $addressData['user_id'] = 3215;
        }

        $order->fromArray($row);
        $address->fromArray($addressData);
        $order->addOne($address);
        $order->save();
    }
}

function importUsers($result)
{
    global $modx;
    $data = $result['data'];
    foreach ($data as $row) {
        if ($row['id'] === 1) {
            continue;
        }
        $groups = [];
        $profileData = $row['profile'];
        $profileData['old_id'] = (int)$row['id'];
        $profileData['extended']['offer'] = $profileData['extended']['offer'] === '1' ? 'Да' : 'Нет';

        if ($profileData['fullname']) {
            $names = explode(' ', trim($profileData['fullname']));
            $profileData['extended']['surname'] = $names[0];
            $profileData['extended']['name'] = $names[1];
            $profileData['extended']['fathername'] = $names[2];
        }

        if (is_array($profileData['extended']['certificate_img'])) {
            $profileData['extended']['certificate_img'] = '';
        }
        if (is_array($profileData['extended']['inn_img'])) {
            $profileData['extended']['inn_img'] = '';
        }
        if (is_array($profileData['extended']['selfemployed_img'])) {
            $profileData['extended']['selfemployed_img'] = '';
        }
        if (is_array($profileData['extended']['pass_one_img'])) {
            $profileData['extended']['pass_one_img'] = '';
        }
        if (is_array($profileData['extended']['pass_two_img'])) {
            $profileData['extended']['pass_two_img'] = '';
        }
        if (is_array($profileData['extended']['insurance_img'])) {
            $profileData['extended']['insurance_img'] = '';
        }

        unset($row['id'], $row['profile'], $profileData['sessionid'], $profileData['internalKey'], $profileData['id']);

        if ($user = $modx->getObject('modUser', ['username' => $row['username']])) {
            $profile = $user->getOne('Profile');
            $user->fromArray($row, '', true);
            $profile->fromArray($profileData, '', true);
            if (!$modx->getCount('modUserGroupMember', ['user_group' => $row['primary_group'], 'member' => $user->get('id')])) {
                $groupMember = $modx->newObject('modUserGroupMember');
                $groupMember->set('user_group', $row['primary_group']);
                $groupMember->set('role', 1); //
                $groups[] = $groupMember;
                $user->addMany($groups);
            }
        } else {
            $user = $modx->newObject('modUser');
            $profile = $modx->newObject('modUserProfile');
            $groupMember = $modx->newObject('modUserGroupMember');
            $groupMember->set('user_group', $row['primary_group']);
            $groupMember->set('role', 1); //
            $groups[] = $groupMember;
            $user->fromArray($row, '', true);
            $profile->fromArray($profileData, '', true);
            $user->addOne($profile);
            $user->addMany($groups);
        }

        $profile->save();
        $user->save();
    }
}

function getTypes()
{
    global $modx;
    $q = $modx->newQuery('modResource');
    $q->where([
        'modResource.template' => 14,
        'modResource.published' => 1,
        'modResource.deleted' => 0,
    ]);
    $q->select('pagetitle, id, old_id');
    if ($q->prepare() && $q->stmt->execute()) {
        $result = $q->stmt->fetchAll(\PDO::FETCH_ASSOC);
        foreach ($result as $row) {
            if ($row['old_id']) {
                $output[$row['old_id']] = $row['id'];
            }
        }
        return $output;
    }
}

function getArticlePrefixes()
{
    global $modx;
    $q = $modx->newQuery('modResource');
    $q->leftJoin('msProductData', 'msProductData', 'modResource.id = msProductData.id');
    $q->where([
        'modResource.template' => 14,
        'modResource.published' => 1,
        'modResource.deleted' => 0,
    ]);
    $q->select('msProductData.id as id, msProductData.article as article');
    if ($q->prepare() && $q->stmt->execute()) {
        $result = $q->stmt->fetchAll(\PDO::FETCH_ASSOC);
        foreach ($result as $row) {
            if ($row['article']) {
                $output[$row['id']] = $row['article'];
            }
        }
        return $output;
    }
}

$types = getTypes();
$parents = [
    '17' => 14,
    '18' => 15,
    '5500' => 16,
    '16' => 17,
    '90' => 18,
    '19' => 19,
    '50227' => 20,
    '69138' => 54754,
    '69140' => 19,
];
function importDesigns($result)
{
    global $modx;
    global $types;
    global $parents;
    $data = $result['data'];

    foreach ($data as $row) {
        $row['old_id'] = $row['id'];
        $row['template'] = 14;
        $row['createdon'] = (int)$row['createdon'];
        $row['editedon'] = (int)$row['editedon'];
        $row['publishedon'] = (int)$row['publishedon'];
        unset($row['id'], $row['longtitle']);
        if (!$product = $modx->getObject('msProduct', ['pagetitle' => $row['pagetitle']])) {
            $product = $modx->newObject('msProduct');
        }
        if ($row['createdby'] !== 1) {
            $row['template'] = 13;
            if ($profile = $modx->getObject('modUserProfile', ['old_id' => $row['createdby']])) {
                $row['createdby'] = $profile->get('internalKey');
                $row['designer'] = $profile->get('fullname');
                unset($profile);
            } else {
                $row['createdby'] = 3215;
                $row['designer'] = 'unknown';
            }
        }

        if ($row['manager_id']) {
            if ($profile = $modx->getObject('modUserProfile', ['old_id' => $row['manager_id']])) {
                $row['manager_id'] = $profile->get('internalKey');
                unset($profile);
            } else {
                $row['manager_id'] = 12;
            }
        }
        if ($row['moderator_id']) {
            if ($profile = $modx->getObject('modUserProfile', ['old_id' => $row['moderator_id']])) {
                $row['moderator_id'] = $profile->get('internalKey');
                unset($profile);
            } else {
                $row['moderator_id'] = 10;
            }
        }

        if ($row['colors']) {
            $row['color'] = explode(';', $row['colors']);
            unset($row['colors']);
        }

        $row['root_id'] = $types[$row['root_id']];
        $row['parent'] = $parents[$row['parent']];
        if ($row['img']) {
            $row['preview'] = $row['img'];
            unset($row['img']);
        }

        $product->fromArray($row);
        $product->save();
        unset($product, $row);
    }
    unset($data);
}

function checkoutDesigns($data)
{
    global $modx;

    $q = $modx->newQuery('modResource');
    $q->select('pagetitle');
    $q->where([
        'template' => 13,
        'class_key' => 'msProduct',
    ]);
    $q->limit($data['limit'], $data['offset']);
    $modx->log(1, print_r('checkoutDesigns::' . $data['offset'], 1));
    if ($q->prepare() && $q->stmt->execute()) {
        $pagetitles = $q->stmt->fetchAll(PDO::FETCH_COLUMN);
        if (!empty($pagetitles)) {
            $data['pagetitles'] = $pagetitles;
            $result = execCURL([], 'http://s29784.h8.modhost.pro/assets/project_files/api.php', '', $data, 1);
            if (!empty($result['data'])) {
                $q = $modx->newQuery('modResource');
                $q->command('update');
                $q->set([
                    'deleted' => 1,
                ]);
                $q->where([
                    'template' => 13,
                    'class_key' => 'msProduct',
                    'pagetitle:IN' => $result['data']
                ]);
                $q->prepare();
                $q->stmt->execute();
            }
            unset($data['pagetitles'], $result);
            $data['offset'] += $data['limit'];
            checkoutDesigns($data);
        }
    }
}

function importTags($result)
{
    global $modx;
    $data = $result['data'];

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

    foreach ($data as $row) {
        if (!$tag = $modx->getObject('TaggerTag', ['tag' => $row['tag']])) {
            $tag = $modx->newObject('TaggerTag');
        }
        $tag->fromArray($row);
        $tag->save();
    }
}

switch ($argv[1]) {
    case 'setfio':
        $profiles = $modx->getIterator('modUserProfile', []);
        foreach ($profiles as $profile) {
            $fullname = $profile->get('fullname');
            $extended = $profile->get('extended');
            $fullname = explode(' ', $fullname);
            $extended['surname'] = $fullname[0] ?? '';
            $extended['name'] = $fullname[1] ?? '';
            $extended['fathername'] = $fullname[2] ?? '';
            $profile->set('extended', $extended);
            $profile->save();
        }
        break;

    case 'set_profile_num':
        $products = $modx->getIterator('modResource', [
            'class_key' => 'msProduct',
            'template' => 13,
            'parent' => 14
        ]);
        foreach ($products as $k => $r) {
            $profile = $modx->getObject('modUserProfile', [
                'internalKey' => $r->get('createdby')
            ]);
            if (!$profile) {
                continue;
            }

            $r->set('profilenum', $r->get('profile_num'));
            $r->save();
        }
        break;

    case 'statisctic':
        // /usr/local/php/php-7.4/bin/php -d display_errors -d error_reporting=E_ALL /home/host1860015/art-sites.ru/htdocs/customfactory/core/elements/v2/console/manage.php statisctic
        // php7.4 -d display_errors -d error_reporting=E_ALL ~/www/core/elements/v2/console/manage.php statisctic
        // php7.4 ~/www/core/elements/v2/console/manage.php statisctic
        //$ozon = new StatisticOzon($modx);
        $wb = new StatisticWb($modx);
        //$ozon->run();
        //$wb->run();
        $wb->setStatictic();
        break;

    case 'nopreview':
        $q = $modx->newQuery('msProductData');
        $q->leftJoin('modResource', 'Resource', 'Resource.id = msProductData.id');
        $q->select('Resource.old_id');
        $q->where('preview IS NULL AND Resource.old_id > 0');
        if ($q->prepare() && $q->stmt->execute()) {
            $modx->log(1, print_r($q->toSQL(), 1));
            $result = $q->stmt->fetchAll(PDO::FETCH_COLUMN);
            file_put_contents(MODX_ASSETS_PATH . 'nopreview.json', json_encode($result, JSON_UNESCAPED_UNICODE));
        }
        break;

    case 'addpreview':
        $previews = json_decode(file_get_contents(MODX_ASSETS_PATH . 'previews.json'), true);
        $q = $modx->newQuery('msProduct');
        $q->leftJoin('msProductData', 'Data');
        $q->where('Data.preview IS NULL AND msProduct.old_id > 0 AND msProduct.class_key = "msProduct"');
        //$q->limit(500);
        $products = $modx->getIterator('msProduct', $q);
        foreach ($products as $product) {
            if (!$previews[$product->get('old_id')]) {
                continue;
            }
            $sql = "UPDATE `cust_ms2_products` SET `preview` = '{$previews[$product->get('old_id')]}' WHERE `id` = {$product->get('id')}";
            $modx->query($sql);
        }
        echo 'Finished';
        break;

    case 'sendemail':
        $baseService = new \CustomServices\Base($modx);
        $baseService->sendEmail([
            'chunk' => '@FILE chunks/emails/userModerateSuccess.tpl',
            'to' => 'shev.art.v@yandex.ru',
            'params' => [],
            'subject' => 'Результаты модерации аккаунта.'
        ]);
        break;

    case 'getnewdesigns':
        // php7.4 www/core/elements/v2/console/manage.php getnewdesigns 2022-01-01 2022-01-02
        $start = $argv[2] ? strtotime($argv[2]) : strtotime(date('d.m.Y'));
        $end = $argv[3] ? strtotime($argv[3]) : $start + 24 * 3600;
        $baseService = new \CustomServices\Base($modx);
        $res = $baseService->getNewDesigns($start, $end);
        echo json_encode($res, JSON_UNESCAPED_UNICODE);
        break;

    case 'generatepreviews':
        // php7.4 -d display_errors -d error_reporting=E_ALL www/core/elements/v2/console/manage.php generatepreviews

        $loadtoselectel = new CustomServices\LoadToSelectel($modx);
        $c = $loadtoselectel->generatePreviews();
        echo 'Loaded ' . $c . PHP_EOL;
        break;

    case 'checkout':
        // php7.4 -d display_errors -d error_reporting=E_ALL www/core/elements/v2/console/manage.php checkout

        $parents = [
            'pillow' => ['new' => 14, 'old' => 17],
            'picture' => ['new' => 15, 'old' => 18],
            'road' => ['new' => 16, 'old' => 5500],
            'wallpaper' => ['new' => 17, 'old' => 16],
            'poster' => ['new' => 18, 'old' => 90],
            'tshirtw' => ['new' => 19, 'old' => 69140],
            'tshirtb' => ['new' => 54754, 'old' => 69138],
        ];
        foreach ($parents as $key => $parent) {
            $pagetitles = [];
            $duplicates = [];
            $orderProducts = [];
            $c = 0;

            $q = $modx->newQuery('modResource');
            $q->leftJoin('msProductData', 'msProductData', 'modResource.id = msProductData.id');
            $q->where([
                'modResource.parent' => $parent['new'],
                'modResource.class_key' => 'msProduct',
                'modResource.template' => 13,
                'modResource.deleted' => 0,
            ]);

            $before = $modx->getCount('modResource', $q);

            $data['parent'] = $parent['old'];
            $data['action'] = 'checkout';
            $result = execCURL([], 'http://s29784.h8.modhost.pro/assets/project_files/api.php', '', $data, 1);
            $q = $modx->newQuery('modResource');
            $q->leftJoin('msProductData', 'msProductData', 'modResource.id = msProductData.id');
            $q->where([
                'modResource.parent' => $parent['new'],
                'modResource.class_key' => 'msProduct',
                'modResource.template' => 13,
                'modResource.deleted' => 0,
                'modResource.pagetitle:NOT IN' => $result['pagetitles'],
            ]);
            $duplicates = $modx->getCount('modResource', $q);
            $products = $modx->getIterator('modResource', $q);

            foreach ($products as $product) {
                if ($modx->getCount('msOrderProduct', ['product_id' => $product->get('id')])) {
                    $orderProducts[] = $product->get('id');
                    continue;
                }
                $product->set('deleted', 1);
                $product->save();
            }

            $output[$key] = [
                'before' => $before,
                'resultTotal' => $result['total'],
                'duplicates' => $duplicates,
                'diff' => $before - $result['total'],
                'orderProducts' => $orderProducts,
            ];
        }
        $modx->log(1, print_r($output, 1));
        break;

    case 'checkUnknown':
        // php7.4 -d display_errors -d error_reporting=E_ALL www/core/elements/v2/console/manage.php checkUnknown
        $unknowns = [];
        $q = $modx->newQuery('modResource');
        $q->leftJoin('msProductData', 'msProductData', 'modResource.id = msProductData.id');
        $q->where([
            'modResource.createdby' => 3215,
            'modResource.class_key' => 'msProduct',
            'modResource.template' => 13,
            'modResource.deleted' => 0,
        ]);
        $q->select('modResource.pagetitle as pagetitle');
        if ($q->prepare() && $q->stmt->execute()) {
            $pagetitles = $q->stmt->fetchAll(PDO::FETCH_COLUMN);
        }

        $data['action'] = 'checkUnknown';
        $data['pagetitles'] = $pagetitles;
        $result = execCURL([], 'http://s29784.h8.modhost.pro/assets/project_files/api.php', '', $data, 1);
        foreach ($result as $item) {
            if ($modx->getCount('modUserProfile', ['email' => $item['email']])) {
                $unknowns[$item['email']] = $item['pagetitle'];
            }
        }
        $output = [
            'before' => count($pagetitles),
            'unknownsTotal' => count($unknowns),
            'unknowns' => $unknowns,
            'result' => $result
        ];
        $modx->log(1, print_r($output, 1));
        break;

    case 'restore':
        //  /usr/local/php/php-7.4/bin/php -d display_errors -d error_reporting=E_ALL /home/host1860015/art-sites.ru/htdocs/customfactory/core/elements/v2/console/manage.php restore

        $q = $modx->newQuery('modResource');
        $q->command('update');
        $q->set([
            'deleted' => 0,
        ]);
        $q->where(['deleted' => 1]);
        $q->prepare();
        $q->stmt->execute();
        break;

    case 'importorders':
        // /usr/local/php/php-7.4/bin/php -d display_errors -d error_reporting=E_ALL /home/host1860015/art-sites.ru/htdocs/customfactory/core/elements/v2/console/manage.php importorders
        // php7.4 -d display_errors -d error_reporting=E_ALL www/core/elements/v2/console/manage.php importorders
        $data['action'] = 'getorders';
        $data['limit'] = 500;
        $data['offset'] = 58000;
        getDatabyApi($data, 'importOrders');
        break;

    case 'importusers':
        // /usr/local/php/php-7.4/bin/php -d display_errors -d error_reporting=E_ALL /home/host1860015/art-sites.ru/htdocs/customfactory/core/elements/v2/console/manage.php importusers
        // php7.4 -d display_errors -d error_reporting=E_ALL www/core/elements/v2/console/manage.php importusers
        $data['action'] = 'getusers';
        $data['limit'] = 100;
        $data['offset'] = 0;
        getDatabyApi($data, 'importUsers');
        break;

    case 'importdesigns':
        // /usr/local/php/php-7.4/bin/php -d display_errors -d error_reporting=E_ALL /home/host1860015/art-sites.ru/htdocs/customfactory/core/elements/v2/console/manage.php importdesigns
        // php7.4 -d display_errors -d error_reporting=E_ALL www/core/elements/v2/console/manage.php importdesigns
        $data['action'] = 'getdesigns';
        $data['limit'] = 500;
        $data['offset'] = 1000;
        getDatabyApi($data, 'importDesigns');
        break;

    case 'checkoutDesigns':
        // /usr/local/php/php-7.4/bin/php -d display_errors -d error_reporting=E_ALL /home/host1860015/art-sites.ru/htdocs/customfactory/core/elements/v2/console/manage.php checkoutDesigns
        // php7.4 -d display_errors -d error_reporting=E_ALL www/core/elements/v2/console/manage.php checkoutDesigns
        $data['action'] = 'checkoutdesigns';
        $data['limit'] = 500;
        $data['offset'] = 0;
        checkoutDesigns($data);
        break;

    case 'changeowner':
        // php7.4 -d display_errors -d error_reporting=E_ALL www/core/elements/v2/console/manage.php changeowner
        $flatfilters = $modx->getService('flatfilters', 'Flatfilters', MODX_CORE_PATH . 'components/flatfilters/');
        $rs = $modx->getIterator('msProduct', ['pagetitle:LIKE' => '%30-04-2024%']);
        foreach ($rs as $r) {
            $pagetitle = $r->get('pagetitle');
            $designer = $r->get('designer');
            if (strpos($pagetitle, $designer) === false) {
                preg_match('/^Дизайн(.*?) от.*?/', $pagetitle, $matches);
                $name = trim($matches[1]);
                if ($profile = $modx->getObject('modUserProfile', ['fullname' => $name])) {
                    $r->set('createdby', $profile->get('internalKey'));
                    $r->set('designer', $profile->get('fullname'));
                    $r->set('profilenum', $profile->get('profile_num'));
                    $r->save();

                    $flatfilters->removeResourceIndex($r->get('id'));
                    $flatfilters->indexingDocument($r);
                    //$modx->log(1, print_r($r->toArray(), 1));
                }
            }
        }
        break;

    case 'finddesigns':
        // php7.4 -d display_errors -d error_reporting=E_ALL www/core/elements/v2/console/manage.php finddesigns
        $sql = "SELECT * FROM cust_ms2_products p
LEFT JOIN cust_site_content r ON p.id = r.id
WHERE p.designer = 'Маркина Татьяна Николаевна' 
OR r.pagetitle LIKE '%Маркина Татьяна Николаевна%'
ORDER BY r.id DESC LIMIT 100";
        $stmt = $modx->query($sql);
        $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
        foreach ($result as $row) {
            $modx->log(1, print_r($row, 1));
        }
        break;

    case 'importtags':
        // php7.4 -d display_errors -d error_reporting=E_ALL www/core/elements/v2/console/manage.php importtags
        $data['action'] = 'gettags';
        $data['limit'] = 100;
        $data['offset'] = 0;
        getDatabyApi($data, 'importTags');
        break;

    case 'correctarticles':
        // php7.4 -d display_errors -d error_reporting=E_ALL www/core/elements/v2/console/manage.php correctarticles
        $date = strtotime('2024-04-15 00:00:00');
        $prefixes = getArticlePrefixes();
        $q = $modx->newQuery('modResource');
        $q->leftJoin('msProductData', 'Product', 'Product.id = modResource.id');
        $q->where([
            'modResource.template' => 13,
            'modResource.deleted' => 0,
            'modResource.published' => 1,
            'Product.article:NOT REGEXP' => '^[0-9][0-9]/',
            'Product.article:!=' => '',
        ]);
        $q->andCondition(['Product.article:NOT REGEXP' => '^W',]);
        $q->prepare();

        //$modx->log(1, print_r($q->toSQL(), 1));
        $resources = $modx->getIterator('modResource', $q);
        $c = 0;
        foreach ($resources as $resource) {
            $tagLabel = $resource->get('tag_label');
            $article = $resource->get('article');
            $root_id = $resource->get('root_id');
            $profileNum = $resource->get('profilenum');
            if (!$article) {
                continue;
            }
            $c++;
            preg_match('/-(.*?)-/', $article, $matches);
            $newArticle = $prefixes[$root_id] . $tagLabel . $matches[0] . $profileNum;
            $resource->set('article', $newArticle);
            $resource->save();
            //$modx->log(1, print_r([$article, $newArticle], 1));
        }
        $modx->log(1, print_r($c, 1));
        break;

    case 'setprofilenum':
        // php7.4 -d display_errors -d error_reporting=E_ALL www/core/elements/v2/console/manage.php setprofilenum

        $q = $modx->newQuery('modUserProfile');
        $q->select('fullname, profile_num');
        if ($q->prepare() && $q->stmt->execute()) {
            $result = $q->stmt->fetchAll(PDO::FETCH_ASSOC);
            foreach ($result as $row) {
                $users[trim($row['fullname'])] = $row['profile_num'];
            }
        }

        $q = $modx->newQuery('msProductData');
        $q->where(['msProductData.profilenum' => 0, 'msProductData.designer:!=' => 'unknown']);
        $q->sortby('msProductData.id', 'DESC');
        $q->limit(1000);
        $q->prepare();
        $products = $modx->getIterator('msProductData', $q);
        foreach ($products as $product) {
            $article = trim($product->get('article'));
            $designer = trim($product->get('designer'));
            $profileNum = $users[$designer];
            if (preg_match('/-0$/', $article)) {
                $article = preg_replace('/-0$/', '-' . $profileNum, $article);
                $product->set('article', $article);
            }
            $product->set('profilenum', $profileNum);
            //$product->save();
            $modx->log(1, print_r([
                $article,
                $designer,
                $profileNum
            ], 1));
        }
        break;

    case 'getdesignlog':
        // php7.4 -d display_errors -d error_reporting=E_ALL www/core/elements/v2/console/manage.php getdesignlog
        $modx->addPackage('moderatorlog', MODX_CORE_PATH . 'components/moderatorlog/model/');
        $productService = new Product($modx);
        $logs = $modx->getIterator('moderatorlogEvent', ['rid' => '70403']);
        foreach ($logs as $log) {
            $data = $log->toArray();
            $data['createdon'] = date('d.m.Y H:i:s', $data['createdon']);
            $data['productData'] = json_decode($data['productData'], true);
            $modx->log(1, print_r($data, 1));
            /*if((int)$data['id'] === 22295) {
                $data['productData']['id'] = $data['rid'];
                $productService->removeProduct($data['productData']);
            }*/
        }
        break;

    case 'restoreproduct':
        // php7.4 -d display_errors -d error_reporting=E_ALL www/core/elements/v2/console/manage.php restoreproduct
        $modx->addPackage('moderatorlog', MODX_CORE_PATH . 'components/moderatorlog/model/');
        if ($log = $modx->getObject('moderatorlogEvent', 23898)) {
            /** @var \modResource $log */
            $data = $log->toArray();
            $productData = json_decode($data['productData'], true);
            $productData['class_key'] = 'msProduct';
            $productData['published'] = $productData['status'] > 0 ? 1 : 0;
            if ($root = $modx->getObject('modResource', $productData['root_id'])) {
                $productData['parent'] = $root->get('parent');
            }
            if (!isset($productData['parent'])) {
                $modx->log(1, 'Не удалось определить родительский ресурс.');
            }
            if (!$resource = $modx->getObject('modResource', ['pagetitle' => $productData['pagetitle']])) {
                $response = $modx->runProcessor('resource/create', $productData);

                if ($response->isError()) {
                    return $modx->error->failure($response->getMessage());
                }
                $newId = $response->response['object']['id'];
            } else {
                $newId = $resource->get('id');
                $resource->fromArray($productData);
                $resource->save();
            }
            if ($newId && $newId !== $data['rid']) {
                $sql = 'UPDATE `cust_site_content` SET `id` = ' . $data['rid'] . ' WHERE `id` = ' . $newId;
                $modx->exec($sql);
                $sql = 'UPDATE `cust_ms2_products` SET `id` = ' . $data['rid'] . ' WHERE `id` = ' . $newId;
                $modx->exec($sql);
                $modx->log(1, print_r([$newId, $data['rid']], 1));
                $modx->log(1, print_r($productData, 1));
            }
        }
        break;

    case 'loadworkflow':
        // php7.4 -d display_errors -d error_reporting=E_ALL www/core/elements/v2/console/manage.php loadworkflow
        $productService = new Product($modx);
        $result = $productService->loadWorkflow(79671);
        break;


}
