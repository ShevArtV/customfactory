<?php
use CustomServices\Render;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

$renderService = new Render($modx);
return $renderService->getFAQ($data, $scriptProperties);

if(empty($data)) return '';

$faq = [];
$nav = '';
$tabs = '';
$questions = '';
$tabNum = 0;
$pdo = $modx->getService('pdoTools');
foreach($data as $item){
    $faq[$item['type']][] = $item;
}

$typeNames = [
    'self-employment' => 'Самозанятость',
    'design' => 'Дизайн',
    'income' => 'Доход',
];

foreach($faq as $type => $items){
    $active = false;
    if($tabNum === 0){
        $active = true;
    }
    $tabNum++;
    $nav .= $pdo->getChunk($navItemTpl, ['active' => $active, 'type' => $type, 'typeName' => $typeNames[$type] ]);
    foreach($items as $item){
        $questions .= $pdo->getChunk($questionTpl, $item);
    }
    $tabs .= $pdo->getChunk($tabTpl, ['questions' => $questions, 'active' => $active, 'type' => $type]);
}

return $pdo->getChunk($wrapTpl, ['nav' => $nav, 'tabs' => $tabs]);