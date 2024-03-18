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
}