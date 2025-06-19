<?php

use CustomServices\Product;

require_once MODX_CORE_PATH . 'vendor/autoload.php';

$productService = new Product($modx);
$result = [
    'success' => 1,
    'message' => '',
    'data' => []
];
$result['data']['tags'] = $productService->getTagsByAlphabet($_POST['query']);
if($tplChar && $tplTag && $tplEmpty){
    $layout = '';
    $pdoTools = $modx->getParser()->pdoTools;
    if(empty($result['data']['tags'])){
        $layout = $pdoTools->parseChunk($tplEmpty, ['query' => $_POST['query']]);
    } else{
        foreach($result['data']['tags'] as $char => $data){
            $tags = '';
            foreach($data as $label => $name){
                $params = array_merge($scriptProperties, ['label' => $label, 'name' => $name]);
                $tags .= $pdoTools->parseChunk($tplTag, $params);
            }
            $params = array_merge($scriptProperties, ['char' => $char, 'tags' => $tags]);
            $layout .= $pdoTools->parseChunk($tplChar, ['char' => $char, 'tags' => $tags]);
        }
    }
    $result['data']['html'] = $layout;
}

if ($SendIt) {
    if ($result['success']) {
        return $SendIt->success($result['message'], $result['data']);
    } else {
        return $SendIt->error($result['message'], $result['data']);
    }
}
return $result['data']['html']?:$result['data']['tags'];
