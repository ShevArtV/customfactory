<?php

namespace CustomServices;

class Base
{
    /** @var \modX */
    protected \modX $modx;

    /** @var \FlatFilters */
    protected \FlatFilters $flatfilters;

    /** @var int $cacheTime */
    protected int $cacheTime;

    public function __construct(\modX $modx)
    {
        $this->modx = $modx;
        $this->initialize();
    }

    protected function initialize()
    {
        $this->flatfilters = $this->modx->getService('flatfilters', 'Flatfilters', MODX_CORE_PATH . 'components/flatfilters/');
        $this->modx->addPackage('moderatorlog', MODX_CORE_PATH . 'components/moderatorlog/model/');
        $this->cacheTime = 10800;
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
            $result = $q->stmt->fetchAll(\PDO::FETCH_ASSOC);
            foreach($result as $row) {
                $output[$row['id']] = $row['pagetitle'];
            }
            $this->modx->cacheManager->set($cacheKey, $output, $this->cacheTime);
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
            $result = $q->stmt->fetchAll(\PDO::FETCH_ASSOC);
            foreach($result as $row) {
                $output[$row['id']] = $row['pagetitle'];
            }
            $this->modx->cacheManager->set($cacheKey, $output, $this->cacheTime);
            return $output;
        }
    }

    public function executeSearch(\xPDOQuery $query, int $configId, array $rids, array $params){
        $tstart = microtime(true);
        if ($query->prepare() && $query->stmt->execute($params)) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            $_SESSION['flatfilters'][$configId]['totalResources'] = $query->stmt->rowCount();
            $rids = $query->stmt->fetchAll(\PDO::FETCH_COLUMN);
        }

        $this->modx->event->returnedValues['rids'] = implode(',', $rids);
    }

    public function setModerateLog(string $fieldKey, $oldValue, $newValue, $rid, $type = 'products', int $user_id = 0)
    {
        $params = [
            'user_id' => $user_id ?: $this->modx->user->get('id'),
            'rid' => $rid,
            'field' => $fieldKey,
            'old_value' => $oldValue,
            'new_value' => $newValue,
            'type' => $type
        ];
        $event = $this->modx->newObject('moderatorlogEvent');
        $event->fromArray($params);
        $event->save();
    }

    public function setWorkflow($workflow, $product){
        $tvvalue = $product->getTVValue('workflow', $workflow);
        $tvvalue = json_decode($tvvalue, true) ?: [];
        $lastIndex = count($tvvalue) - 1;

        if($workflow['moderator_comment']){
            $tvvalue[$lastIndex]['moderator_comment'] = $workflow['moderator_comment'];
            $tvvalue[$lastIndex]['moderator_date'] = $workflow['moderator_date'];
            $tvvalue[$lastIndex]['screens'] = $workflow['screens'];
        }else{
            $tvvalue[] = $workflow;
        }

        $product->setTVValue('workflow', json_encode($tvvalue));
    }
}