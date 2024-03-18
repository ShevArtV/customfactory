<?php
// /usr/local/php/php-7.4/bin/php -d display_errors -d error_reporting=E_ALL /home/host1860015/art-sites.ru/htdocs/customfactory/core/elements/v2/cron/run.php

use CustomServices\LoadToSelectel;

define('MODX_API_MODE', true);

require_once dirname(__FILE__, 5) . '/index.php';
require_once MODX_CORE_PATH . 'vendor/autoload.php';

$modx->getService('error', 'error.modError');
$modx->setLogLevel(modX::LOG_LEVEL_ERROR);

switch($argv[1]) {
    case 'loadtoselectel':
        $loadtoselectel = new CustomServices\LoadToSelectel($modx);
        $loadtoselectel->startUploading();
        break;
}