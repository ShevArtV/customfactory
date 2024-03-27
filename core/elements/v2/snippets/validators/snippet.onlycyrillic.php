<?php

$msg = $validator->formit->config[$key.'.vTextPasswordConfirm'] ?: 'Только кириллица.';
$isCyrillic = preg_match('/^[А-Яа-яЁё]+$/u', $value);
if(!$isCyrillic){
    $validator->addError($key, $msg);
}
return true;