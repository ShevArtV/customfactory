<?php
if($input){
    $result = array('start' => '', 'end' => '');
    $arr = explode(' ', $input);
    if(!$options){
        $options = 30;
    }
    $chunks = array_chunk($arr, $options);

    foreach ($chunks as $k => $chunk){
        if($k == 0){
            $result['start'] = implode(' ', $chunk);
        }else{
            $result['end'] .= implode(' ', $chunk);
        }
    }
    return $result;
}