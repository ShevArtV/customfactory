<?php
use CustomServices\Render;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

$renderService = new Render($modx);
return $renderService->getFAQ($data, $scriptProperties);