<?php
use CustomServices\Product;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

$productService = new Product($modx);
$output = $productService->getTagsByAlphabet($_POST['query']);
if($tplChar && $tplTag && $tplEmpty){
    $layout = '';
    $pdoTools = $modx->getParser()->pdoTools;
    if(empty($output)) return $pdoTools->parseChunk($tplEmpty, ['query' => $_POST['query']]);
    foreach($output as $char => $data){
        $tags = '';
        foreach($data as $label => $name){
            $params = array_merge($scriptProperties, ['label' => $label, 'name' => $name]);
            $tags .= $pdoTools->parseChunk($tplTag, $params);
        }
        $params = array_merge($scriptProperties, ['char' => $char, 'tags' => $tags]);
        $layout .= $pdoTools->parseChunk($tplChar, ['char' => $char, 'tags' => $tags]);
    }

    return $layout;
}
return $output;