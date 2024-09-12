<?php
// /usr/local/php/php-7.4/bin/php -d display_errors -d error_reporting=E_ALL /home/host1860015/art-sites.ru/htdocs/customfactory/core/elements/v2/cron/run.php loadtoselectel
// php7.4 -d display_errors -d error_reporting=E_ALL ~/www/core/elements/v2/cron/run.php loadtoselectel
// php7.4 -d display_errors -d error_reporting=E_ALL ~/www/core/elements/v2/cron/run.php import_articles

use CustomServices\LoadToSelectel;
use CustomServices\Designer;
use CustomServices\Product;
use CustomServices\Report;
use CustomServices\Statistic\StatisticOzon;
use CustomServices\Statistic\StatisticWb;

define('MODX_API_MODE', true);

require_once dirname(__FILE__, 5) . '/index.php';
require_once MODX_CORE_PATH . 'vendor/autoload.php';

$modx->getService('error', 'error.modError');
$modx->setLogLevel(modX::LOG_LEVEL_ERROR);

//$modx->log(1, print_r('CRON RUN width command: ' . $argv[1], 1));
switch ($argv[1]) {
    case 'loadtoselectel':
        $modx->cacheManager->refresh();
        $loadtoselectel = new LoadToSelectel($modx);
        $loadtoselectel->startUploading();
        break;
    case 'remove_user_files':
        // php7.4 -d display_errors -d error_reporting=E_ALL ~/www/core/elements/v2/cron/run.php remove_user_files
        $designerService = new Designer($modx);
        $designerService->removeUserFiles(['status' => 2, 'files_deleted!=' => 1]);
        break;
    case 'remove_unactive_users':
        $designerService = new Designer($modx);
        $designerService->removeUnactiveUsers();
        break;
    case 'import_articles':
        // php7.4 -d display_errors -d error_reporting=E_ALL ~/www/core/elements/v2/cron/run.php import_articles
        $productService = new Product($modx);
        $productService->importArticles();
        break;
    case 'get_statistic':
        // php7.4 -d display_errors -d error_reporting=E_ALL ~/www/core/elements/v2/cron/run.php get_statistic
        $ozon = new StatisticOzon($modx);
        $wb = new StatisticWb($modx);
        $ozon->run();
        $wb->run();
        $wb->setStatictic();
        $wb->indexing();
        echo 'Statistic is ready' . PHP_EOL;
        break;
    case 'article_report':
        $fields = [
            'id' => 'ID',
            'root_id' => 'Тип товара',
            'article' => 'Артикул',
            'tags' => 'Тэг',
            'color' => 'Цвета',
            'size' => 'Размеры',
            'article_barcode' => 'Артикул для штрих кода',
            'article_oz' => 'Артикул Озона',
            'name_barcode' => 'Название для штрихкода',
            'status' => 'Статус'
        ];
        $conditions = [
            'Data.status' => 3,
            'Data.prev_status:!=' => 6,
            'Data.class_key' => 'msProduct',
            'Data.createdby:!=' => 1,
            'Data.article_wb' => '',
            'Data.article_oz' => '',
        ];
        $productService = new Product($modx);
        $data = $productService->getReportData($fields, $conditions);
        if (!empty($data['ids'])) {
            $data['filename'] = 'article_report';
            $reportService = new Report($modx);
            $path = $reportService->generate($data);
        }
        break;
    case 'delete_products':
        $date = date('d.m.Y');
        $productService = new Product($modx);
        $q = $modx->newQuery('msProduct');
        $q->leftJoin('msProductData', 'Data');
        $q->where(['Data.delete_at' => $date]);
        $products = $modx->getIterator('msProduct', $q);
        foreach ($products as $product) {
            $productService->removeProduct($product->toArray());
        }
        break;
}
