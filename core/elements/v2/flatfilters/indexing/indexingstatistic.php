<?php

require_once dirname(__FILE__, 5) . '/components/flatfilters/handlers/indexing/indexingresources.class.php';

class IndexingStatistic extends IndexingResources
{
    /**
     * @var string
     */
    private string $statisticClassName = 'OuterStatisticsItem';

    protected function initialize(): void
    {
        parent::initialize();
        //$this->modx->addPackage('salesstatistics', MODX_CORE_PATH . 'components/salesstatistics/model/');
        $this->modx->addPackage('outerstatistics', MODX_CORE_PATH . 'components/outerstatistics/model/');
    }

    public function getResourceData($resource): array
    {
        $resourceData = $resource->toArray();
        $result = $this->getStatisticFields($resourceData['id']);
        if (empty($result)) {
            return [];
        }
        return array_merge($resourceData, $result);
    }

    protected function getStatisticFields($rid): array
    {
        $q = $this->modx->newQuery($this->statisticClassName);
        $q->select("{$this->statisticClassName}.market as market, {$this->statisticClassName}.date as date");
        $q->where(["{$this->statisticClassName}.product_id" => $rid]);
        $output = [];
        $tstart = microtime(true);
        if ($q->prepare() && $q->stmt->execute()) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            if (!$result = $q->stmt->fetchAll(\PDO::FETCH_ASSOC)) {
                return $output;
            }

            $output = [
                'market' => [],
                'date' => []
            ];

            foreach ($result as $item) {
                if (!in_array($item['market'], $output['market'])) {
                    $output['market'][] = $item['market'];
                }
                if (!in_array($item['date'], $output['date'])) {
                    $output['date'][] = $item['date'];
                }
            }
        }
        return $output;
    }
}
