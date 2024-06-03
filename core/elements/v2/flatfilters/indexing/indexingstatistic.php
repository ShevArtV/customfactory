<?php

require_once dirname(__FILE__, 5) . '/components/flatfilters/handlers/indexing/indexingresources.class.php';

class IndexingStatistic extends IndexingResources
{
    protected function initialize(): void
    {
        parent::initialize();
        $this->modx->addPackage('salesstatistics', MODX_CORE_PATH . 'components/salesstatistics/model/');
    }
    public function getResourceData($resource)
    {
        $resourceData = $resource->toArray();
        $result = $this->getStatisticFields($resourceData['id']);
        if(empty($result)){
            return false;
        }
        return array_merge($resourceData, $result);
    }
    protected function getStatisticFields($rid){
        $q = $this->modx->newQuery('SalesStatisticsItem');
        $q->select('SalesStatisticsItem.market as market, SalesStatisticsItem.date as date');
        $q->where(['SalesStatisticsItem.product_id' => $rid]);
        $output = [];
        $tstart = microtime(true);
        if ($q->prepare() && $q->stmt->execute()) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            if(!$result = $q->stmt->fetchAll(PDO::FETCH_ASSOC)){
                return $output;
            }

            $output = [
                'market' => [],
                'date' => []
            ];

            foreach($result as $item){
                if(!in_array($item['market'], $output['market'])){
                    $output['market'][] =  $item['market'];
                }
                if(!in_array($item['date'], $output['date'])){
                    $output['date'][] =  $item['date'];
                }
            }

        }
        return $output;
    }
}
