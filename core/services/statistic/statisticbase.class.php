<?php

namespace CustomServices\Statistic;

use CustomServices\Logging;

class StatisticBase
{
    public function __construct($modx)
    {
        $this->modx = $modx;
        $this->initialize();
    }

    protected function initialize()
    {
        $this->ms2 = $this->modx->getService('miniShop2');
        $this->ms2->initialize('web');
        $this->corePath = $this->modx->getOption('core_path');
        $this->basePath = $this->modx->getOption('base_path');
        $date = date('d-m-Y');
        if (!file_exists($this->basePath . 'assets/statistic_log')) {
            mkdir($this->basePath . 'assets/statistic_log');
        }
        $logpath = $this->basePath . 'assets/statistic_log/log_' . $date . '.txt';
        /*if(file_exists($logpath)){
            unlink($logpath);
        }*/
        $this->logging = new Logging(['logpath' => $logpath, 'debug' => 1]);
        $this->headers = [
            'Content-Type: application/json',
            'Accept: application/json'
        ];
        $this->url = '';
        $this->query = [];
        $this->dateFrom = date('Y-m-d', time() - (3 * 86400));
        $this->now = date('Y-m-d');
        if (!$this->modx->addPackage('salesstatistics', $this->corePath . 'components/salesstatistics/model/')) {
            return false;
        }
    }

    protected function getData($method, $ispost = false)
    {
        if (!$this->url) {
            $this->logging->writeLog("Base::getData", "Невозможно получить данные. Не указан URL.");
            return false;
        }
        $result = $this->execCURL($this->headers, $this->url, $method, $this->query, $ispost);
        if ($result['errors'] || $result['code'] || empty($result)) {
            $this->logging->writeLog("Base::getData", "При получении данных методом $method возникла ошибка.", array_merge(['query' => $this->query], $result));
            return false;
        }
        file_put_contents($this->basePath . $method . '.json', json_encode($result, JSON_UNESCAPED_UNICODE));
        return $result;
    }

    protected function createOrder($data)
    {
        if (!empty($data['products'])) {
            foreach ($data['products'] as $pid) {
                $this->ms2->cart->add($pid, 1, []);
            }
        } else {
            $this->ms2->cart->add($data['product_id'], 1, []);
        }
        $this->ms2->order->config['json_response'] = true;
        $this->ms2->order->add('receiver', $data['receiver']);
        $this->ms2->order->add('email', $data['email']);
        $this->ms2->order->add('payment', 1);
        $this->ms2->order->add('delivery', 1);
        $this->ms2->order->add('text_address', $data['text_address']);
        $this->ms2->order->add('order_comment', $data['order_comment']);
        $response = $this->ms2->order->submit();
        if (!is_array($response)) {
            $response = json_decode($response, 1);
        }
        if ($response['data']['msorder']) {
            if ($order = $this->modx->getObject('msOrder', $response['data']['msorder'])) {
                $order->set('createdon', $data['createdon']);
                $order->set('status', $data['status']);
                $order->save();
            }
            return $order;
        } else {
            if (!$response) {
                $response = [];
            }
            $this->logging->writeLog('Base::createOrder', 'Не удалось создать заказ.', array_merge($data, $response));
        }
        return false;
    }

    protected function getProductByField($field, $value)
    {
        $q = $this->modx->newQuery('msProductData');
        $q->leftJoin('modResource', 'modResource', 'msProductData.id=modResource.id');
        $q->select($this->modx->getSelectColumns('msProductData', 'msProductData', '', ['id']));
        $q->select($this->modx->getSelectColumns('modResource', 'modResource', '', ['createdby']));
        $q->where("msProductData.$field = '$value'");
        $q->prepare();
        return $this->modx->getObject('msProductData', $q);
    }

    public function setStatictic()
    {
        $q = $this->modx->newQuery('msOrderProduct');
        $q->groupby('`msOrderProduct`.`product_id`');
        $products = $this->modx->getIterator('msOrderProduct', $q);
        foreach ($products as $product) {
            $pid = $product->get('product_id');
            $q = $this->modx->newQuery('msOrderProduct');
            $q->leftJoin('msOrder', 'Order');
            $q->leftJoin('msOrderAddress', 'Address', '`Order`.`id`=`Address`.`order_id`');
            $q->select('COUNT(`msOrderProduct`.`order_id`) as orders');
            $q->select('SUM(CASE WHEN `Order`.`status` = 2 THEN `msOrderProduct`.`cost` ELSE 0 END) as pays');
            $q->select('SUM(CASE WHEN `Order`.`status` = 2 THEN 1 ELSE 0 END) as sales');
            $q->select('SUM(CASE WHEN `Order`.`status` = 4 THEN 1 ELSE 0 END) as returns');
            $q->select('`msOrderProduct`.`product_id`');
            $q->select('`Order`.`createdon`');
            $q->select('`Address`.`text_address` as `market`');
            $q->groupby('`Order`.`createdon`');
            $q->where("`msOrderProduct`.`product_id` = $pid");
            $q->prepare();
            if ($statement = $this->modx->query($q->toSQL())) {
                $r = $statement->fetchAll(\PDO::FETCH_ASSOC);
                if (is_array($r)) {
                    foreach ($r as $k => $item) {
                        $item['date'] = strtotime($item['createdon']);
                        unset($item['createdon']);
                        if (!$statistic = $this->modx->getObject('SalesStatisticsItem', [
                            'product_id' => $item['product_id'],
                            'date' => $item['date'],
                            'market' => $item['market'],
                        ])) {
                            $statistic = $this->modx->newObject('SalesStatisticsItem');
                        }
                        $statistic->fromArray($item);
                        $statistic->save();
                    }
                }
            }
        }
        $this->logging->writeLog("Base::setStatictic", "Статистика установлена.");
    }

    public function execCURL(array $headers, string $url, string $method, array $post_data, bool $ispost = false): array
    {
        $curl = curl_init();
        $url = $url . $method;

        if ($ispost) {
            //$this->logging->writeLog("Base::execCURL", "Отправляем POST");
            curl_setopt($curl, CURLOPT_POSTFIELDS, json_encode($post_data));
        } elseif ($post_data) {
            $post_data = http_build_query($post_data);
            $url .= '?' . $post_data;
        }

        curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);
        curl_setopt($curl, CURLOPT_CONNECTTIMEOUT, 20);
        curl_setopt($curl, CURLOPT_TIMEOUT, 60);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_FOLLOWLOCATION, 1);
        curl_setopt($curl, CURLINFO_HEADER_OUT, true);
        $raw = curl_exec($curl);
        $result = json_decode($raw, true);
        $info = curl_getinfo($curl);

        //$this->logging->writeLog("Base::execCURL", "DATA:", $post_data);
        //$this->logging->writeLog("Base::execCURL", "INFO:", $info);
        //$this->logging->writeLog("Base::execCURL", "URL: {$url}");
        //$this->logging->writeLog("Base::execCURL", "HEADERS: ", $headers);
        //$this->logging->writeLog("Base::execCURL", "RAW: ", $raw);

        return is_array($result) ? $result : [];
    }

    public function indexing()
    {
        $FF = $this->modx->getService('flatfilters', 'Flatfilters', MODX_CORE_PATH . 'components/flatfilters/');
        if ($config = $this->modx->getObject('ffConfiguration', 4)) {
            $configData = $config->toArray();
            $configData['filters'] = json_decode($configData['filters'], 1);
            $configData['default_filters'] = json_decode($configData['default_filters'], 1);
            if ($configData['offset'] === $configData['total']) {
                $configData['offset'] = 0;
            }
            $className = "ffIndex4";
            $tableName = $this->modx->getTableName($className);
            $sql = "TRUNCATE TABLE {$tableName}";
            $this->modx->exec($sql);

            $tableName = $this->modx->getTableName('ffConfigResource');
            $sql = "DELETE FROM {$tableName} WHERE config_id = 4";
            $this->modx->exec($sql);

            if (!$Indexing = $FF->loadClass($configData, 'indexing')) {
                $this->logging->writeLog("Base::indexing", "Ошибка получения класса индексации.");
                return false;
            }
            $offset = $configData['offset'];
            $total = $configData['total'] ?: 1;
            $percent = round($offset / $total * 100);
            while ($offset < $total) {
                $result = $Indexing->indexConfig();
                $total = $result['total'];
                $offset = $result['offset'];
                $newPercent = round($offset / $total * 100);
                if($percent !== $newPercent){
                    $percent = $newPercent;
                    $this->logging->writeLog("Base::indexing", "Проиндексировано: {$percent}%");
                }
                $Indexing->config['offset'] = $result['offset'];
                $config->fromArray($result);
                $config->save();
            }
            $this->logging->writeLog("Base::indexing", "Статистика проиндексирована.");
            return true;
        }
        $this->logging->writeLog("Base::indexing", "Конфигурация не найдена.");
        return false;
    }
}
