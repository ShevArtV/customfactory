<?php
$format = 'd.m.Y';
$date = $input ?: date($format);
if($options !== 'prev_month'){
    $end = $date;
    $start = date($format, strtotime("$end - 1 $options"));
}else{
    $end = date($format, strtotime("$date - 1 month"));
    $start = date($format, strtotime("$end - 1 month"));
}

return "$start,$end";