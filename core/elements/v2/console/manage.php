<?php

// /usr/local/php/php-7.4/bin/php -d display_errors -d error_reporting=E_ALL /home/host1860015/art-sites.ru/htdocs/customfactory/core/elements/v2/console/manage.php

define('MODX_API_MODE', true);
require_once dirname(__FILE__, 5) . '/index.php';

$modx->getService('error', 'error.modError');
$modx->setLogLevel(modX::LOG_LEVEL_ERROR);
if (file_exists(MODX_CORE_PATH . 'cache/logs/error.log')) {
    unlink(MODX_CORE_PATH . 'cache/logs/error.log');
}
switch ($argv[1]) {
    case 'root_id':
        $adminProducts = $modx->getIterator('modResource', [
            'class_key' => 'msProduct',
            'template' => 14,
            'id:!=' => 51970
        ]);
        $comparison = [];
        foreach ($adminProducts as $adminProduct) {
            $comparison[$adminProduct->get('old_id')] = $adminProduct->get('id');
            $adminProduct->set('root_id', $adminProduct->get('id'));
            $adminProduct->save();
        }

        $products = $modx->getIterator('modResource', [
            'class_key' => 'msProduct',
            'template' => 13,
            'parent' => 20
        ]);
        foreach ($products as $k => $product) {
            $rood_id = $product->get('root_id');
            if ($rood_id === $comparison[$rood_id]) continue;
            $product->set('root_id', $comparison[$rood_id]);
            $product->save();
        }
        echo 'Finished ' . $argv[1];
        break;

    case 'tags':
        $modx->addPackage('tagger', MODX_CORE_PATH . 'components/tagger/model/');
        $products = $modx->getIterator('modResource', [
            'class_key' => 'msProduct',
            'template' => 13,
            'parent' => 14
        ]);
        $output = [];
        foreach ($products as $k => $product) {
            $q = $modx->newQuery('TaggerTagResource');
            $q->leftJoin('TaggerTag', 'Tag');
            $q->select($modx->getSelectColumns('TaggerTag', 'Tag', '', ['tag', 'label']));
            $q->where([
                'TaggerTagResource.resource' => $product->get('id')
            ]);
            $q->prepare();
            if ($statement = $modx->query($q->toSQL())) {
                $tag = $statement->fetchAll(PDO::FETCH_ASSOC);
                if (isset($output[$product->get('id')])) continue;
                $product->set('tags', [$tag[0]['tag']]);
                $product->set('tag_label', $tag[0]['label']);
                $product->save();
                $output[$product->get('id')] = $tag[0];
            }
        }

        echo 'Finished ' . $argv[1];
        break;

    case 'change_offer':
        $profiles = $modx->getIterator('modUserProfile');
        foreach ($profiles as $profile) {
            $extended = $profile->get('extended');
            if (!isset($extended['offer'])) {
                $extended['offer'] = 'Нет';
                $profile->set('extended', $extended);
                $profile->save();
            }
        }
        break;

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

    case 'set_colors':
        $products = $modx->getIterator('modResource', [
            'class_key' => 'msProduct',
            'template' => 13,
            'parent' => 20
        ]);
        foreach ($products as $k => $r) {
            $colors = $r->get("colors");
            if (!$colors) continue;
            $colors = explode(';', $colors);
            $r->set('color', $colors);
            $r->save();
        }
        break;

    case 'remove_preview':
        $products = $modx->getIterator('modResource', [
            'class_key' => 'msProduct',
            'template' => 13,
            'parent' => 20
        ]);
        foreach ($products as $k => $r) {
            $r->set('preview', $r->get('img'));
            $r->save();
        }
        break;

    case 'generate_preview':
        $start = microtime(true);
        $path = '/assets/temp/W28600925-70092.tif';
        $preview = $modx->runSnippet('pThumb', array('input' => $path, 'options' => 'w=249&h=281&zc=1&q=60'));
        $end = microtime(true);
        $duration = $end - $start;
        echo sprintf('%.3f', $duration);
        echo $preview;
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
            if (!$profile) continue;

            $r->set('profilenum', $r->get('profile_num'));
            $r->save();
        }
        break;

}