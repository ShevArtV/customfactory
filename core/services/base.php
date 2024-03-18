<?php

namespace CustomServices;

class Base
{
    /** @var \modX */
    protected \modX $modx;

    /** @var \FlatFilters */
    protected \FlatFilters $flatfilters;

    public function __construct(\modX $modx)
    {
        $this->modx = $modx;
        $this->initialize();
    }

    protected function initialize()
    {
        $this->flatfilters = $this->modx->getService('flatfilters', 'Flatfilters', MODX_CORE_PATH . 'components/flatfilters/');
    }

    public function getStatuses()
    {
        $output = [];
        $q = $this->modx->newQuery('modTemplateVarResource');
        $q->select('value');
        $q->where(['tmplvarid' => 14, 'contentid' => 1]);

        $tstart = microtime(true);
        if ($q->prepare() && $q->stmt->execute()) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            $statuses = $q->stmt->fetch(\PDO::FETCH_COLUMN);
            $statuses = json_decode($statuses, true);
            foreach ($statuses as $status) {
                $id = $status['sid'];
                $type = $status['type'];
                unset($status['MIGX_id'], $status['sid'], $status['type']);
                $status['allow'] = $status['allow'] ? explode(',', $status['allow']) : [];
                $output[$type][$id] = $status;
            }
        }
        return $output;
    }

    public function getProductTypes()
    {
        $cacheKey = 'getProductTypes::cache';
        if ($output = $this->modx->cacheManager->get($cacheKey)) {
            return $output;
        }
        $q = $this->modx->newQuery('msProduct');
        $q->select('id, pagetitle');
        $q->where(['msProduct.template' => 14]);
        $tstart = microtime(true);
        if ($q->prepare() && $q->stmt->execute()) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            $output = $q->stmt->fetchAll(\PDO::FETCH_ASSOC);
            $this->modx->cacheManager->set($cacheKey, $output);
            return $output;
        }
    }

    public function getParents()
    {
        $cacheKey = 'getParents::cache';
        if ($output = $this->modx->cacheManager->get($cacheKey)) {
            return $output;
        }
        $q = $this->modx->newQuery('modResource');
        $q->select('id, pagetitle');
        $q->where(['modResource.class_key' => 'msCategory', 'modResource.parent' => 13]);
        $tstart = microtime(true);
        if ($q->prepare() && $q->stmt->execute()) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            $output = $q->stmt->fetchAll(\PDO::FETCH_ASSOC);
            $this->modx->cacheManager->set($cacheKey, $output);
            return $output;
        }
    }

    public function executeSearch(\xPDOQuery $query, int $configId, array $rids, array $params){
        $tstart = microtime(true);
        $this->modx->log(1, print_r($params, 1));
        if ($query->prepare() && $query->stmt->execute($params)) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            $_SESSION['flatfilters'][$configId]['totalResources'] = $query->stmt->rowCount();
            $rids = $query->stmt->fetchAll(\PDO::FETCH_COLUMN);
        }

        $this->modx->event->returnedValues['rids'] = implode(',', $rids);
    }
}