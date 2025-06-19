<?php

use CustomServices\Product;

require_once dirname(__FILE__, 5) . '/vendor/autoload.php';

require_once dirname(__FILE__, 5) . '/components/flatfilters/handlers/filtering/filteringresources.class.php';

class FilteringStatistic extends FilteringResources
{

    protected function getOutputIds($rids): string
    {
        $this->modx->log(1, print_r($rids, 1));
        $productService = new Product($this->modx);

        if ($statistics = $productService->getStatistic(explode(',', $rids))) {
            $rids = implode(',', array_keys($statistics));
        }

        $sql = $this->getOutputSQL($rids);
        $sql .= 'ORDER BY FIELD(Resource.id,  ' . $rids . ')';
        $sql .= " LIMIT {$this->limit} OFFSET {$this->offset}";
        /* получаем список id для отображения на странице */
        if ($statement = $this->execute($sql)) {
            $rids = $statement->fetchAll(\PDO::FETCH_COLUMN);
            $rids = implode(',', $rids);
        }

        return $rids;
    }
}
