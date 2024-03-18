<?php
if(!$input){
    $input = date('d-m-Y');
}
if(!$options){
    $options = '%l, %d %m %Y';
}
$month_arr = array(
    '01' => 'Января',
    '02' => 'Февраля',
    '03' => 'Марта',
    '04' => 'Апреля',
    '05' => 'Мая',
    '06' => 'Июня',
    '07' => 'Июля',
    '08' => 'Августа',
    '09' => 'Сентября',
    '10' => 'Октября',
    '11' => 'Ноября',
    '12' => 'Декабря'
);

$day_names =  array(
    "Воскресенье",
    "Понедельник",
    "Вторник",
    "Среда",
    "Четверг",
    "Пятница",
    "Суббота"
);

if(!is_numeric($input)){
    $input = strtotime($input);
}
$month = strftime('%m', $input);
$day = strftime('%d', $input);
$year = strftime('%Y', $input);
$day_num = strftime('%w', $input);
return str_replace(array("%l", "%d", "%m", "%Y"), array($day_names[$day_num], $day, $month_arr[$month], $year), $options);