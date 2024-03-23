<?php

namespace CustomServices\Statistic;

class StatisticOzon extends StatisticBase
{

    protected function initialize()
    {
        parent::initialize();
        $headers = [
            'Api-Key: 5beef6a1-0280-45c7-a9a1-9b1fee8f76c0',
            'Client-Id: 28123',
        ];
        $this->headers = array_merge($this->headers, $headers);
        $this->url = 'https://api-seller.ozon.ru/v3/posting/fbs/';
        //$this->url = 'https://api-seller.ozon.ru/v3/posting/fbs/unfulfilled/';
        $this->method = 'list';
        $now = date('d.m.Y');
        $nowTime = strtotime($now);
        //$this->dateFrom = date('Y-m-d\TH:i:s\Z', strtotime('2023-12-01'));
        $this->dateFrom = date('Y-m-d\TH:i:s\Z', $nowTime - 86400);

        $this->now = date('Y-m-d\TH:i:s\Z', $nowTime);
        //$this->now = date('Y-m-d\TH:i:s\Z', strtotime('2023-10-05'));
        $this->count = 0;
        $this->limit = 1000;
        $this->query = [
            'dir' => 'ASC',
            'filter' => [
                'since' => $this->dateFrom,
                'status' => '',
                'to' => $this->now
            ],
            'limit' => $this->limit,
            'offset' => 0,
            'translit' => true,
            'with' => [
                'analytics_data' => false,
                'financial_data' => false
            ]
        ];
        /*$this->query = [
            'dir' => 'ASC',
            'filter' => [
                'cutoff_from' => $this->dateFrom,
                'status' => '',
                'cutoff_to' => $this->now
            ],
            'limit' => $this->limit,
            'offset' => 0,
            'translit' => true,
            'with' => [
                'analytics_data' => false,
                'financial_data' => false
            ]
        ];*/

    }

    public function run($next = false)
    {
        if (!$next) {
            $this->logging->writeLog("OzonHandler::init", "Начато получение данных из Озон за период с {$this->dateFrom} по {$this->now}.");
        }

        if (!$orders = $this->getData($this->method, 1)) {
            return false;
        }
        $this->count += $this->prepareMsOrderData($orders['result']['postings']);
        if ($orders['result']['has_next']) {
            $this->query['offset'] += $this->limit;
            $this->run(1);
        } else {
            $this->logging->writeLog("OzonHandler::init", "Количество заказов полученных от Озон: {$this->count}");
            $this->logging->writeLog("OzonHandler::init", "Импорт данных завершён.");
        }
    }

    private function prepareMsOrderData(array $orders)
    {
        foreach ($orders as $item) {
            $this->logging->writeLog("OzonHandler::prepareMsOrderData", "Кол-во товаров: " . count($item['products']));
            $products = [];
            $createdby = '';
            foreach ($item['products'] as $p) {
                if (!$product = $this->getProductByField('article', $p['offer_id'])) {
                    $this->logging->writeLog("OzonHandler::prepareMsOrderData", "Товар с артикулом {$p['offer_id']} не найден.");
                    $this->logging->writeLog("OzonHandler::prepareMsOrderData", "Заказ {$item['order_id']} не будет добавлен на сайт.");
                    //continue;
                } else {
                    $this->logging->writeLog("OzonHandler::prepareMsOrderData", "Товар с артикулом {$p['offer_id']} успешно найден.");
                    $products[] = $product->get('id');
                    if(!$createdby){
                        $createdby = $product->get('createdby');
                    }
                    unset($product);
                }
            }

            if (!$profile = $this->modx->getObject('modUserProfile', ['internalKey' => $createdby])) {
                $this->logging->writeLog("OzonHandler::prepareMsOrderData", "Дизайнер с ID {$createdby} не найден.");
                $this->logging->writeLog("OzonHandler::prepareMsOrderData", "Заказ {$item['odid']} не будет добавлен на сайт.");
                continue;
            }
            $this->logging->writeLog("OzonHandler::prepareMsOrderData", "Статус Озон: " . $item['status']);
            $status = 1;
            if ($item['status'] === 'delivered') {
                $status = 2;
            }
            if ($item['status'] === 'cancelled') {
                $status = 4;
            }
            $email = $profile->get('email');
            $fullname = $profile->get('fullname');
            unset($profile);
            $orderData = [
                'products' => $products,
                'receiver' => $fullname,
                'email' => $email,
                'text_address' => 'Ozon',
                'status' => $status,
                'createdon' => $item['in_process_at'],
                'order_comment' => $item['order_id']
            ];
            if (!$order = $this->modx->getObject('msOrder', ['order_comment' => $item['order_id']])) {
                if (!$order = $this->createOrder($orderData)) continue;
                $this->logging->writeLog("OzonHandler::prepareMsOrderData", "Создан заказ с ORDER_ID {$order->get('id')}", $orderData);
            } else {
                $orderData['updatedon'] = date('Y-m-d');
                $order->fromArray($orderData);
                $order->save();
                $this->logging->writeLog("OzonHandler::prepareMsOrderData", "Обновлён заказ с ORDER_ID {$order->get('id')}", $orderData);
            }
        }
        return count($orders);
    }
}