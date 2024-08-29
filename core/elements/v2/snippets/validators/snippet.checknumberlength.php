<?php
if($value){
    $msg = $validator->formit->config[$key.'.vTextCheckNumberLength'] ?: 'Количество цифр должно быть равно {$param}.';
    $msg = str_replace('{$param}', $param, $msg);
    $value = preg_replace('/[^0-9]/', '', $value);
    $modx->log(1, print_r($value, 1));
    $modx->log(1, print_r(strlen($value), 1));
    if(strlen($value) != $param){
        $validator->addError($key, $msg);
    }
}
return true;
