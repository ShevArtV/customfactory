<?php

use CustomServices\Base;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

$baseService = new Base($modx);
return $baseService->getStatuses();