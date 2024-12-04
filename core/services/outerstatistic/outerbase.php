<?php

namespace CustomServices\OuterStatistic;

use CustomServices\Logging;

class OuterBase
{

    protected string $url = 'https://api.1dplab.ru/39-1880/v1/market-place-stat/';

    protected array $headers = [
        'Content-Type: application/json',
        'Accept: application/json',
        'Authorization: Bearer K4w5fHtcTpy34cY-vcNQJTLG8apystA7'
    ];

    public array $markets = ['wb' => 'Wildberries', 'ozon' => 'Ozon'];

    public array $query = [];

    public function __construct($modx)
    {
        $this->modx = $modx;
        $this->initialize();
    }

    protected function initialize()
    {
        $this->corePath = $this->modx->getOption('core_path');
        $this->basePath = $this->modx->getOption('base_path');
        $logPath = $this->basePath . 'assets/outer_statistic_log';
        $date = date('d-m-Y');
        if (!file_exists($logPath)) {
            mkdir($logPath);
        }
        $logPath .= '/log_' . $date . '.txt';
        /*if(file_exists($logpath)){
            unlink($logpath);
        }*/
        $this->logging = new Logging(['logpath' => $logPath, 'debug' => 1]);

        if (!$this->modx->addPackage('outerstatistics', $this->corePath . 'components/outerstatistics/model/')) {
            return false;
        }
    }

    public function getData($method, $query, $page = 1)
    {
        $query['page'] = $page;

        if (!$this->url) {
            $this->logging->writeLog(__METHOD__, "Невозможно получить данные. Не указан URL.");
            return false;
        }
        $result = $this->execCURL($this->headers, $this->url, $method, $query);
        if (empty($result['items'])) {
            return true;
        }

        foreach ($result['items'] as $item) {
            if(!$data = $this->getProductDataByArticle($item['offer_id'])){
                continue;
            }
            $data = array_merge($item, $data);
            $data['market'] = $this->markets[$method];
            $data['date'] = strtotime($query['dateFrom']);
            $this->setStatictic($data);
        }

        if ($result['_meta']['currentPage'] < $result['_meta']['pageCount']) {
            $this->getData($method, $query,$result['_meta']['currentPage'] + 1);
        }else{
            $this->logging->writeLog(__METHOD__, "За период с {$query['dateFrom']} по {$query['dateTo']} получено {$result['_meta']['totalCount']} записей о статистике с {$this->markets[$method]}.");
        }

        return true;
    }

    protected function getProductDataByArticle($value)
    {
        $q = $this->modx->newQuery('msProductData');
        $q->leftJoin('modResource', 'modResource', 'msProductData.id=modResource.id');
        $q->select($this->modx->getSelectColumns('msProductData', 'msProductData', '', ['id', 'price']));
        $q->select($this->modx->getSelectColumns('modResource', 'modResource', '', ['createdby']));
        $q->where("msProductData.article_ya = '$value'");
        $q->prepare();
        if($q->stmt->execute()){
            return $q->stmt->fetch(\PDO::FETCH_ASSOC);
        }
    }

    public function setStatictic($data)
    {
        if (!$statistic = $this->modx->getObject('OuterStatisticsItem', [
            'product_id' => $data['id'],
            'date' => $data['date'],
            'market' => $data['market'],
        ])) {
            $statistic = $this->modx->newObject('OuterStatisticsItem');
        }

        $statistic->fromArray([
            'product_id' => $data['id'],
            'date' => $data['date'],
            'market' => $data['market'],
            'orders' => $data['totalOrders'],
            'sales' => $data['totalDeliveredQuantity'],
            'returns' => $data['totalCancelledOrders'],
            'pays' => $data['totalDeliveredQuantity'] * $data['price'],
        ]);

        $statistic->save();
        return true;

        $q = $this->modx->newQuery('msOrderProduct');
        if (!empty($where)) {
            $q->where($where);
        }
        $q->groupby('`msOrderProduct`.`product_id`');
        $products = $this->modx->getIterator('msOrderProduct', $q);
        $count = $this->modx->getCount('msOrderProduct', $q);
        $index = 0;
        foreach ($products as $product) {
            $index++;
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
                    foreach ($r as $item) {
                        $date = date('Y-m-d', strtotime($item['createdon']));
                        $item['date'] = strtotime($date);
                        unset($item['createdon']);
                        if (!$statistic = $this->modx->getObject('SalesStatisticsItem', [
                            'product_id' => $item['product_id'],
                            'date' => $item['date'],
                            'market' => $item['market'],
                        ])) {
                            $statistic = $this->modx->newObject('SalesStatisticsItem');
                        } else {
                            $item['orders'] += $statistic->get('orders');
                            $item['pays'] += $statistic->get('pays');
                            $item['returns'] += $statistic->get('returns');
                            $item['sales'] += $statistic->get('sales');
                        }
                        $statistic->fromArray($item);
                        $statistic->save();
                    }
                }
            }
            file_put_contents($this->basePath . 'assets/setstatistic_progress.txt', "$index/$count");
        }
        $this->logging->writeLog(__METHOD__, "Статистика установлена.");
    }


    public function execCURL(array $headers, string $url, string $method, array $post_data, bool $ispost = false): array
    {
        $curl = curl_init();
        $url = $url . $method;

        if ($ispost) {
            //$this->logging->writeLog(__METHOD__, "Отправляем POST");
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

        //$this->logging->writeLog(__METHOD__, "DATA:", $post_data);
        //$this->logging->writeLog(__METHOD__, "INFO:", $info);
        //$this->logging->writeLog(__METHOD__, "URL: {$url}");
        //$this->logging->writeLog(__METHOD__, "HEADERS: ", $headers);
        //$this->logging->writeLog(__METHOD__, "RAW: ", $raw);

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
                $this->logging->writeLog(__METHOD__, "Ошибка получения класса индексации.");
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
                if ($percent !== $newPercent) {
                    $percent = $newPercent;
                    $this->logging->writeLog(__METHOD__, "Проиндексировано: {$percent}%");
                }
                $Indexing->config['offset'] = $result['offset'];
                $config->fromArray($result);
                $config->save();
            }
            $this->logging->writeLog(__METHOD__, "Статистика проиндексирована.");
            return true;
        }
        $this->logging->writeLog(__METHOD__, "Конфигурация не найдена.");
        return false;
    }
}
