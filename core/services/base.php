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

    /** @var array $cacheOptions */
    protected array $cacheOptions;

    /** @var \pdoTools $pdoTools */
    protected \pdoTools $pdoTools;

    /** @var string $httpHosst */
    protected string $httpHost;

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
        $this->httpHost = $this->modx->getOption('http_host', '', 'unknown');
        $this->pdoTools = $this->modx->getParser()->pdoTools;
        $this->cacheOptions = [\xPDO::OPT_CACHE_KEY => 'customservices'];
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
        $q->leftJoin('modResource', 'Parent', 'msProduct.parent = Parent.id');
        $q->select('msProduct.id as id, msProduct.pagetitle as pagetitle');
        $q->where([
            'msProduct.template' => 14,
            'msProduct.published' => 1,
            'Parent.published' => 1,
            'msProduct.deleted' => 0,
            'Parent.deleted' => 0,
        ]);
        $tstart = microtime(true);
        if ($q->prepare() && $q->stmt->execute()) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            $result = $q->stmt->fetchAll(\PDO::FETCH_ASSOC);
            foreach ($result as $row) {
                $output[$row['id']] = $row['pagetitle'];
            }

            $this->modx->cacheManager->set($cacheKey, $output, $this->cacheTime, $this->cacheOptions);
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
        $q->where(['modResource.class_key' => 'msCategory', 'modResource.parent' => 13, 'modResource.published' => 1, 'modResource.deleted' => 0]);
        $tstart = microtime(true);
        if ($q->prepare() && $q->stmt->execute()) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            $result = $q->stmt->fetchAll(\PDO::FETCH_ASSOC);
            foreach ($result as $row) {
                $output[$row['id']] = $row['pagetitle'];
            }
            $this->modx->cacheManager->set($cacheKey, $output, $this->cacheTime, $this->cacheOptions);
            return $output;
        }
    }

    public function executeSearch(\xPDOQuery $query, int $configId, array $rids, array $params)
    {
        $tstart = microtime(true);
        if ($query->prepare() && $query->stmt->execute($params)) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            $_SESSION['flatfilters'][$configId]['totalResources'] = $query->stmt->rowCount();
            $rids = $query->stmt->fetchAll(\PDO::FETCH_COLUMN);
        }

        $this->modx->event->returnedValues['rids'] = implode(',', $rids);
    }

    public function setModerateLog(array $params)
    {
        $allowedKeys = [
            'pagetitle',
            'editedon',
            'createdon',
            'createdby',
            'template',
            'deleted',
            'delete_at',
            'tags',
            'color',
            'size',
            'print',
            'preview',
            'root_id',
            'designer',
            'article',
            'article_ya',
            'article_oz',
            'article_wb',
            'status',
            'prev_status',
            'count_files',
            'tag_label',
            'profilenum',
            'moderator_id',
            'manager_id',
            'introtext',
            'content',
        ];
        $productData = [];
        if(isset($params['productData']) && is_array($params['productData'])){
            foreach($params['productData'] as $key => $value){
                if(in_array($key, $allowedKeys)){
                    $productData[$key] = $value;
                }
            }
        }
        $params['productData'] = json_encode($productData, JSON_UNESCAPED_UNICODE);
        $params['user_id'] = $params['user_id'] ?? $this->modx->user->get('id');
        $params['createdon'] = time();
        $event = $this->modx->newObject('moderatorlogEvent');
        $event->fromArray($params);
        $event->save();
    }

    public function setWorkflow($workflow, $product)
    {
        $tvvalue = $product->getTVValue('workflow', $workflow);
        $tvvalue = json_decode($tvvalue, true) ?: [];
        $lastIndex = count($tvvalue) ? count($tvvalue) - 1 : 0;

        if($workflow['moderator_comment']){
            $tvvalue[$lastIndex]['moderator_comment'] = $workflow['moderator_comment'];
            $tvvalue[$lastIndex]['moderator_date'] = $workflow['moderator_date'];
            $tvvalue[$lastIndex]['screens'] = $workflow['screens'];

            if(!$tvvalue[$lastIndex]['designer_comment']){
                $tvvalue[$lastIndex]['designer_comment'] = $workflow['designer_comment'];
                $tvvalue[$lastIndex]['designer_data'] = $workflow['designer_date'];
                $tvvalue[$lastIndex]['print'] = $workflow['print'];
                $tvvalue[$lastIndex]['preview'] = $workflow['preview'];
            }
        }else{
            $tvvalue[] =  $workflow;
        }

        $product->setTVValue('workflow', json_encode($tvvalue));
    }

    public function sendEmail(array $data)
    {
        $chunk = $data['chunk'];
        $to = $data['to'];
        $subject = $data['subject'];
        $from = $data['from'];
        $reply = $data['reply'];
        $fromName = $data['fromName'];
        $params = $data['params'];

        if (!$chunk) {
            $this->modx->log(1, 'Письмо не отправлено. Не передан чанк');
            return false;
        }

        if (!$to) {
            $this->modx->log(1, 'Письмо не отправлено. Не передан email получателя');
            return false;
        } else {
            $to = explode(',', $to);
        }

        if (!$subject) {
            $subject = 'noreply@' . $this->httpHost;
        }

        if (!$from) {
            $from = $this->modx->getOption('mail_use_smtp')
                ? $this->modx->getOption('mail_smtp_user')
                : 'noreply@' . $this->httpHost;
        }
        if (!$reply) {
            $reply = $from;
        }
        if (!$fromName) {
            $fromName = $this->modx->getOption('site_name');
        }
        if (!$params) {
            $params = [];
        } elseif (!is_array($params)) {
            $params = json_decode($params, true);
        }

        $this->modx->getService('mail', 'mail.modPHPMailer');

        $message = $this->pdoTools->getChunk($chunk, $params);
        $this->modx->mail->set(\modMail::MAIL_BODY, $message);
        $this->modx->mail->set(\modMail::MAIL_FROM, $from);
        $this->modx->mail->set(\modMail::MAIL_FROM_NAME, $fromName);
        $this->modx->mail->set(\modMail::MAIL_SUBJECT, $subject);
        foreach ($to as $t) {
            $this->modx->mail->address('to', $t);
        }
        $this->modx->mail->address('reply-to', $reply);
        if (isset($attachment)) {
            $this->modx->mail->attach($attachment);
        }

        $this->modx->mail->setHTML(true);
        if (!$this->modx->mail->send()) {
            $this->modx->log(1, 'При отправке письма произошла ошибка: ' . $this->modx->mail->mailer->ErrorInfo);
        }

        $this->modx->mail->reset();
    }

    public function getNewDesigns($start, $end){
        $result = [];
        $q = $this->modx->newQuery('msProductData');
        $q->leftJoin('modResource', 'modResource', 'msProductData.id=modResource.id');
        $q->select($this->modx->getSelectColumns('msProductData', 'msProductData'));
        $q->select($this->modx->getSelectColumns('modResource', 'modResource'));
        $q->where([
            'modResource.editedon:>=' => $start,
            'modResource.editedon:<' => $end,
            'article:!=' => '',
            'status' => 4,
        ]);
        $q->prepare();
        $resources = $this->modx->getIterator('msProduct', $q);
        foreach ($resources as $resource) {
            $images = [];
            if ($profile = $this->modx->getObject('modUserProfile', ['internalKey' => $resource->get('createdby')])) {
                $name = $profile->get('fullname');
                $lk_num = $profile->get('profile_num');
            }

            if ($category = $this->modx->getObject('modResource', $resource->get('parent'))) {
                $category_name = $category->get('pagetitle');
            }

            if ($type = $this->modx->getObject('modResource', $resource->get('root_id'))) {
                $type_name = $type->get('pagetitle');
            }
            if ($print = $resource->get('print')) {
                $print = explode('|', $print);
                foreach ($print as $p) {
                    if (strpos($p, 'http') === false) {
                        $images[] = $this->printFullPath . $p;
                    } else {
                        $images[] = $p;
                    }
                }
            }

            $result[] = [
                'Дата/Время' => $resource->get('editedon'),
                'Артикул' => $resource->get('article'),
                'Статус' => $resource->get('status'),
                'ФИО дизайнера' => $name ?: '',
                'Номер ЛК' => $lk_num ?: '',
                'Категория' => $category_name ?: '',
                'Тип товара' => $type_name ?: '',
                'Превью' => $this->imgFullPath . $resource->getTVValue('img'),
                'Файлы для печати' => $images
            ];
        }
        //$this->modx->log(1, print_r($result, 1));
        return $result;
    }
}
