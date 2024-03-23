<?php

namespace CustomServices;

class Logging
{
    public $logpath;
    private $debug;

    public function __construct($params)
    {
        $this->logpath = $params['logpath'] ?: $params['base_path'] . 'assets/orders-send-log/' . $params['order_id'] . '.txt';

        $this->debug = $params['debug'];
    }

    public function writeLog($method, $msg, $data = [], $noDate = false)
    {
        if ($this->debug) {
            if (!$noDate) {
                $date = date('d.m.Y H:i:s');
                $text = "**$date** [$method] $msg" . PHP_EOL;
            } else {
                $text = PHP_EOL . "*************************** [$method] $msg ***************************" . PHP_EOL;
            }


            if (!empty($data)) {
                file_put_contents($this->logpath, $text . print_r($data, 1) . PHP_EOL, FILE_APPEND);
            } else {
                file_put_contents($this->logpath, $text, FILE_APPEND);
            }
        }
    }
}