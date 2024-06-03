<?php

use CustomServices\Designer;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

$designerService = new Designer($modx);
return $designerService->getUsers($scriptProperties);