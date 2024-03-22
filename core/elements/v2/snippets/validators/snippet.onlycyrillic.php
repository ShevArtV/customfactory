<?php

$msg = $validator->formit->config[$key.'.vTextPasswordConfirm'] ?: 'Только кириллица.';
$isCyrillic = preg_match('/^[А-Яа-яЁё]+$/u', $value);
$modx->log(1, print_r($value, 1));
if(!$isCyrillic){
    $validator->addError($key, $msg);
}
return true;