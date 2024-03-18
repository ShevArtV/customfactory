<?php

use CustomServices\Designer;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

$designerService = new Designer($modx);
$method = $SendIt->presetName;
if (method_exists($designerService, $method)) {
    $result = $designerService->$method($_POST);
    if ($result['success']) {
        return $SendIt->success($result['msg'], $result);
    } else {
        return $SendIt->error($result['msg'], $result);
    }
}
return $SendIt->error("Метод не найден {$method}");