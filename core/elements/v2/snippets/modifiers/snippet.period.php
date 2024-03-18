<?php
$format = 'd.m.Y';
$end = $input ?: date($format);
$start = date($format, strtotime("$end - 1 $options"));
return "$start,$end";