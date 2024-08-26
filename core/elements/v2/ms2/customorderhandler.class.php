<?php
if (!class_exists('msOrderHandler')) {
    require_once dirname(__FILE__, 4) . '/components/minishop2/handlers/msorderhandler.class.php';
}

class CustomOrderHandler extends msOrderHandler
{
    /**
     * @param array $data
     *
     * @return array|string
     */
    public function submit($data = [])
    {
        $response = $this->ms2->invokeEvent('msOnSubmitOrder', [
            'data' => $data,
            'order' => $this,
        ]);
        if (!$response['success']) {
            return $this->error($response['message']);
        }
        if (!empty($response['data']['data'])) {
            $this->set($response['data']['data']);
        }

        $response = $this->getDeliveryRequiresFields();
        if ($this->ms2->config['json_response']) {
            $response = json_decode($response, true);
        }
        if (!$response['success']) {
            return $this->error($response['message']);
        }
        $requires = $response['data']['requires'];

        $errors = [];
        foreach ($requires as $v) {
            if (!empty($v) && empty($this->order[$v])) {
                $errors[] = $v;
            }
        }
        if (!empty($errors)) {
            return $this->error('ms2_order_err_requires', $errors);
        }

        $user_id = $this->ms2->getCustomerId();
        if (empty($user_id) || !is_int($user_id)) {
            return $this->error(is_string($user_id) ? $user_id : 'ms2_err_user_nf');
        }

        $cart_status = $this->ms2->cart->status();
        if (empty($cart_status['total_count'])) {
            return $this->error('ms2_order_err_empty');
        }

        $delivery_cost = $this->getCost(false, true);
        $cart_cost = $this->getCost(true, true) - $delivery_cost;
        $num = $this->getNewOrderNum();

        /** @var msOrder $msOrder */
        $msOrder = $this->storageHandler->getForSubmit(
            compact('user_id', 'num', 'cart_cost', 'cart_status', 'delivery_cost')
        );

        $response = $this->ms2->invokeEvent('msOnBeforeCreateOrder', [
            'msOrder' => $msOrder,
            'order' => $this,
        ]);
        if (!$response['success']) {
            return $this->error($response['message']);
        }

        if ($msOrder->save()) {
            $response = $this->ms2->invokeEvent('msOnCreateOrder', [
                'msOrder' => $msOrder,
                'order' => $this,
            ]);
            if (!$response['success']) {
                return $this->error($response['message']);
            }

            if ($this->storage === 'session') {
                $this->ms2->cart->clean();
                $this->clean();
            }
            if (empty($_SESSION['minishop2']['orders'])) {
                $_SESSION['minishop2']['orders'] = [];
            }
            $_SESSION['minishop2']['orders'][] = $msOrder->get('id');

            // Trying to set status "new"
            $status_new = $this->modx->getOption('ms2_status_new', null, 1);
            $response = $this->ms2->changeOrderStatus($msOrder->get('id'), $status_new);
            if ($response !== true) {
                return $this->error($response, ['msorder' => $msOrder->get('id')]);
            }

            // Reload order object after changes in changeOrderStatus method
            /** @var msOrder $msOrder */
            $msOrder = $this->modx->getObject('msOrder', ['id' => $msOrder->get('id')]);

            /** @var msPayment $payment */
            $payment = $this->modx->getObject(
                'msPayment',
                ['id' => $msOrder->get('payment'), 'active' => 1]
            );
            if ($payment) {
                $response = $payment->send($msOrder);
                if ($this->config['json_response']) {
                    @session_write_close();
                    return is_array($response) ? json_encode($response) : $response;
                }
                if (!empty($response['data']['redirect'])) {
                    $this->modx->sendRedirect($response['data']['redirect']);
                }
                if (!empty($response['data']['msorder'])) {
                    $redirect = $this->modx->context->makeUrl(
                        $this->modx->resource->id,
                        ['msorder' => $response['data']['msorder']]
                    );
                    $this->modx->sendRedirect($redirect);
                }
                $this->modx->sendRedirect($this->modx->context->makeUrl($this->modx->resource->id));
            } else {
                if ($this->config['json_response']) {
                    return $this->success('', ['msorder' => $msOrder->get('id')]);
                }
                $redirect = $this->modx->context->makeUrl(
                    $this->modx->resource->id,
                    ['msorder' => $msOrder->get('id')]
                );
                $this->modx->sendRedirect($redirect);
            }
            return $this->success();
        }

        return $this->error();
    }
}
