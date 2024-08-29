<?php
use CustomServices\Designer;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

$designerService = new Designer($modx);
$keys = explode(',', $hook->formit->config['allowFiles']);
if(!empty($keys)){
    $extended = str_replace('&quot;', '"', $hook->getValue('extended'));
    $extended = $extended ? json_decode($extended, true) : [];
    $profile = $modx->user->getOne('Profile');
    $userExtended = $profile->get('extended');
    foreach($keys as $key){
        if(strpos($key, 'extended') === 0){
            $key = preg_replace('/extended\[|\]/', '', $key);
            $path = $designerService->prepareFiles($key, $extended);
            $existPath = MODX_BASE_PATH . $userExtended[$key];
            $extended[$key] = $path;
        }else{
            $path = $designerService->prepareFiles($key, $_POST);
            $existPath = MODX_BASE_PATH . $profile->get($key);
            $hook->setValue($key, $path);
        }
        if(file_exists($existPath) && !is_dir($existPath)){
            unlink($existPath);
        }
    }
    $hook->setValue('extended', json_encode($extended, JSON_UNESCAPED_UNICODE));
}

return true;
