<?php

use CustomServices\Report;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

$reportService = new Report($modx);
$path = $reportService->generate($_POST);
return $SendIt->success('Загрузка скоро начнётся.', ['path' => $path, 'filename' => basename($path)]);
