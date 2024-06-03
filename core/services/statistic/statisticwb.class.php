<?php

namespace CustomServices\Statistic;

class StatisticWb extends StatisticBase
{
    protected function initialize()
    {
        parent::initialize();
        $headers = [
            'Authorization: ' . $this->modx->getOption('wb_token')
        ];
        $this->headers = array_merge($this->headers, $headers);
        $this->url = 'https://statistics-api.wildberries.ru/api/v1/supplier/';
        //$this->dateFrom = '2024-04-04';
        $this->query = ['dateFrom' => $this->dateFrom, 'dateTo' => $this->now, 'flag' => 0];
    }


    public function run()
    {
        $this->logging->writeLog("WbHandler::init", "Начато получение данных из WB за период с {$this->dateFrom} по {$this->now}.");

        if (!$orders = $this->getData('orders')) {
            return false;
        }
        $this->logging->writeLog("WbHandler::init", "Получено заказов " . count($orders));

        $this->prepareMsOrderData($orders);

        if (!$sales = $this->getData('sales')) {
            $this->logging->writeLog("WbHandler::init", "Не удалось получить данные по продажам.");
        }
        $this->updateOrders($sales);

        $this->logging->writeLog("WbHandler::init", "Импорт данных завершён.");
    }

    private function prepareMsOrderData(array $orders)
    {
        //$this->logging->writeLog("WbHandler::prepareMsOrderData", "Заказы полученные от WB: ", $orders);
        $this->logging->writeLog("WbHandler::prepareMsOrderData", "Количество заказов полученных от WB: " . count($orders));

        foreach ($orders as $item) {
            if (!$item['nmId']) {
                continue;
            }

            if (!$item['srid']) {
                $this->logging->writeLog("WbHandler::prepareMsOrderData", "Идентификатор заказа отсутствует.");
                continue;
            }

            if ($this->modx->getCount('msOrder', ['order_comment' => $item['srid']])) {
                continue;
            }

            $this->logging->writeLog("WbHandler::prepareMsOrderData", "Данные из WB", $item);
            if (!$product = $this->getProductByField('article_wb', $item['nmId'])) {
                $this->logging->writeLog("WbHandler::prepareMsOrderData", "Товар с артикулом {$item['nmId']} не найден.");
                $this->logging->writeLog("WbHandler::prepareMsOrderData", "Заказ {$item['srid']} не будет добавлен на сайт.");
                continue;
            }
            $product_id = $product->get('id');
            $createdby = $product->get('createdby');
            unset($product);
            if (!$profile = $this->modx->getObject('modUserProfile', ['internalKey' => $createdby])) {
                $this->logging->writeLog("WbHandler::prepareMsOrderData", "Дизайнер с ID {$createdby} не найден.");
                $this->logging->writeLog("WbHandler::prepareMsOrderData", "Заказ {$item['srid']} не будет добавлен на сайт.");
                continue;
            }

            $email = $profile->get('email');
            $fullname = $profile->get('fullname');
            unset($profile);
            $orderData = [
                'product_id' => $product_id,
                'receiver' => $fullname,
                'email' => $email,
                'text_address' => 'Wildberries',
                'status' => 1,
                'createdon' => $item['lastChangeDate'],
                'order_comment' => $item['srid']
            ];

            if (!$order = $this->createOrder($orderData)) {
                continue;
            }

            $this->logging->writeLog("WbHandler::prepareMsOrderData", "Создан заказ с ID {$order->get('id')}", $orderData);
        }
        $this->logging->writeLog("WbHandler::prepareMsOrderData", "Обработка заказов из WB завершена");
        return true;
    }

    private function updateOrders($sales)
    {
        foreach ($sales as $item) {
            if (!$item['nmId']) {
                continue;
            }
            if (!$item['srid']) {
                $this->logging->writeLog("WbHandler::prepareMsOrderData", "Идентификатор заказа отсутствует.");
                continue;
            }
            $order = $this->modx->getObject('msOrder', ['order_comment' => $item['srid']]);
            if (!$order || $order->get('status') == 4) {
                continue;
            }
            $saleID = preg_replace('/[0-9]/', '', $item['saleID']);
            $this->logging->writeLog("WbHandler::updateOrders", "Данные о продаже: ", $item);
            switch ($saleID) {
                case 'R':
                case 'B':
                    $status = 4;
                    break;
                case 'S':
                case 'D':
                case 'A':
                    $status = 2;
                    break;
                default:
                    $status = 1;
                    break;
            }
            $order->set('status', $status);
            $order->set('updatedon', $item['lastChangeDate']);
            $order->save();
        }
    }
} 
