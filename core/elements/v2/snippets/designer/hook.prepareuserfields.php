<?php
$legalForm = $hook->getValue('legal_form');
if($legalForm === 'ИП'){
    $hook->setValue('inn', $hook->getValue('inn_ip'));
}
if($legalForm === 'Самозанятый'){
    $hook->setValue('inn', $hook->getValue('inn_self'));
}
