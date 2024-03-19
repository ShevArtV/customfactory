<?php

namespace CustomServices;

use CustomServices\Product;

class Designer extends Base
{

    /** @var string $basePath */
    private string $basePath;

    /** @var string $assetsPath */
    private string $assetsPath;

    /** @var array $statuses */
    private array $statuses;

    /** @var Product $productService */
    private Product $productService;

    protected function initialize()
    {
        parent::initialize();
        $this->basePath = $this->modx->getOption('base_path');
        $this->assetsPath = $this->modx->getOption('assets_path');
        $this->statuses = $this->getStatuses();
        $this->productService = new Product($this->modx);
    }

    public function getProgress(int $id = 0)
    {
        $user = $id ? $this->modx->getObject('modUser', $id) : $this->modx->user;
        $offerResource = $this->modx->getObject('modResource', 51976);
        $progress = 0;
        $total = 0;
        $steps = ['reg' => 0, 'email' => 0, 'status' => 0, 'offer' => 0, 'prods' => 0];
        $allow = 0;
        $offer_key = 'offer' . $offerResource->get('introtext');

        if ($user) {
            $progress += 40;
            $steps['reg'] = 1;
            $steps['email'] = 1;
            $total += 2;
            if ($profile = $user->getOne('Profile')) {
                $extended = $profile->get('extended');
                if ($profile->get('status') == 2) {
                    $progress += 20;
                    $steps['status'] = 1;
                    $total += 1;
                }
                if (isset($extended[$offer_key])) {
                    $progress += 20;
                    $steps['offer'] = 1;
                    $total += 1;
                }
            }
            if ($this->modx->getCount('modResource', ['createdby' => $user->get('id')])) {
                $progress += 20;
                $steps['prods'] = 1;
                $total += 1;
            }
            if ($progress == 100 || ($progress == 80 && !$steps['prods'])) {
                $allow = 1;
            }
        }

        $this->modx->setPlaceholders(
            [
                'user_progress' => $progress,
                'user_total' => $total,
                'user_allow_add' => 0 ?: $allow,
            ]
        );
        $this->modx->setPlaceholder('user_steps', $steps);
    }

    public function prepareUpdateOffer($resource)
    {
        $upd = $resource->get('tv12');
        if (!$upd[0]) {
            return $resource;
        }
        $oldResource = $this->modx->getObject('modResource', $resource->get('id'));
        $history = $resource->get('tv11') ? json_decode($resource->get('tv11'), true) : [];
        $newHystoryItem['text'] = $oldResource->get('content');
        $newHystoryItem['id'] = $oldResource->get('introtext');
        $newHystoryItem['MIGX_id'] = count($history) + 1;
        if (!empty($history)) {
            foreach ($history as $k => $item) {
                if ($item['id'] === $newHystoryItem['id']) {
                    $history[$k]['text'] = $newHystoryItem['text'];
                    $newHystoryItem = [];
                }
            }
        }
        if (!empty($newHystoryItem)) {
            $history[] = $newHystoryItem;
        }

        file_put_contents($this->assetsPath . 'history.json', json_encode($history));
    }

    public function updateOffer($resource)
    {
        $filePath = $this->assetsPath . 'history.json';
        if (file_exists($filePath)) {
            $resource->setTVValue('update_offer', false);
            $resource->setTVValue('offers_history', file_get_contents($filePath));
            unlink($filePath);
        }
    }

    public function prepareFiles($key, $data)
    {
        $senditTempPath = $this->modx->getOption('si_uploaddir', '', '[[+asseetsUrl]]components/sendit/uploaded_files/');
        $senditTempPath = str_replace('[[+asseetsUrl]]', $this->assetsPath, $senditTempPath);
        if (!empty($data[$key])) {
            $sourceFile = $senditTempPath . session_id() . '/' . $data[$key];
            if (file_exists($sourceFile)) {
                $targetFolder = $this->assetsPath . 'userfiles/' . $this->modx->user->get('id') . '/';
                if (!file_exists($targetFolder)) {
                    mkdir($targetFolder, 0777, true);
                }
                $extension = pathinfo($sourceFile, PATHINFO_EXTENSION);
                $key = preg_replace('/extended\[|\]/', '', $key);
                $targetFile = $targetFolder . $key . '.' . $extension;
                rename($sourceFile, $targetFile);
                return str_replace($this->basePath, '', $targetFile);
            }
        }
    }

    public function searchUsers(string $query, string $rids, int $configId)
    {
        $phone = preg_replace('/[^0-9]/', '', $query);
        $phone = preg_replace('/(\d)(\d{3})(\d{3})(\d{2})(\d{2})$/', '+7(\2)\3-\4-\5', $phone);
        $date = strtotime($query) ? '%' . strtotime($query) . '%' : $query;
        $query = "%{$query}%";
        $rids = explode(',', $rids);
        $params = array(
            ':query' => $query,
            ':phone' => $phone ?: $query,
            ':date' => $date
        );

        $q = $this->modx->newQuery('modUser');
        $q->leftJoin('modUserProfile', 'Profile');
        $q->select('modUser.id as id');
        $q->where(
            "
                    (modUser.username LIKE :query 
                    OR Profile.fullname LIKE :query
                    OR Profile.profile_num LIKE :query
                    OR Profile.city LIKE :query 
                    OR Profile.email LIKE :query 
                    OR Profile.phone = :phone 
                    OR Profile.createdon LIKE :date 
                    OR Profile.pass_num LIKE :query 
                    OR Profile.pass_series LIKE :query
                    OR Profile.inn LIKE :query)                    
            "
        );
        $q->andCondition(['modUser.id:IN' => $rids]);
        $this->executeSearch($q, $configId, $rids, $params);
    }

    public function updateUser($data)
    {
        if (!$user = $this->modx->getObject('modUser', (int)$data['id'])) {
            return [
                'success' => false,
                'msg' => 'Произошла ошибка при обновлении пользователя.',
                'user_id' => (int)$data['id'],
            ];
        }

        $profile = $user->getOne('Profile');

        $oldData = array_merge($user->toArray(), $profile->toArray());
        $oldStatus = $oldData['status'];

        if ($data['status']
            && !empty($this->statuses['designer'][$oldStatus]['allow'])
            && $oldStatus !== $data['status']
            && !in_array($data['status'], $this->statuses['designer'][$oldStatus]['allow'])
        ) {
            $data['status'] = $oldStatus;
        } else {
            $this->setModerateLog('status', $oldStatus, $data['status'], $data['id'], 'user');
        }

        $profile->fromArray($data);
        $profile->save();
        $user->fromArray($data);
        $user->save();

        $this->flatfilters->removeResourceIndex((int)$data['id']);
        $this->flatfilters->indexingUser($user);

        return [
            'success' => true,
            'msg' => 'Данные пользователя обновлены.',
            'user_id' => (int)$data['id']
        ];
    }

    public function unactiveUsers($data)
    {
        $data['active'] = 0;
        return [
            'success' => true,
            'msg' => 'Статус пользователей изменен.',
            'selectedIds' => $this->setUsersField($data, 'active'),
        ];
    }

    public function setStatusUsers($data)
    {
        return [
            'success' => true,
            'msg' => 'Статус пользователей изменен.',
            'selectedIds' => $this->setUsersField($data, 'status'),
        ];
    }

    public function setUsersField(array $data, string $key): array
    {
        $selectedIds = !is_array($data['selected_id']) ? json_decode($data['selected_id'], true) : $data['selected_id'];
        if (!empty($selectedIds)) {
            foreach ($selectedIds as $selectedId) {
                $result = $this->updateUser(['id' => $selectedId, $key => $data[$key], 'comment' => $data['comment']]);
                if (!$result['success']) {
                    $this->modx->log(1, '[Designer::setUsersField] ' . $result['msg']);
                }
            }
        }
        return $selectedIds;
    }

    public function removeUser(\modUser $user)
    {
        $id = $user->get('id');

        $this->removeUserFiles($id, $user->get('old_id'));

        $this->removeUserProducts($id);

        $this->flatfilters->removeResourceIndex($id);

        $user->remove();

        return [
            'success' => true,
            'msg' => 'Пользователь удалён.',
            'user_id' => $id
        ];
    }

    public function removeUserFiles(int $id, int $old_id)
    {
        $targetFolder = $this->assetsPath . 'userfiles/' . $id . '/';
        $targetFolderAlt = $this->assetsPath . 'userfiles/' . $old_id . '/';
        if (file_exists($targetFolder)) {
            $this->removeDir($targetFolder);
        }
        if (file_exists($targetFolderAlt)) {
            $this->removeDir($targetFolderAlt);
        }
    }

    public function removeUserProducts(int $id)
    {
        $products = $this->modx->getIterator('modResource', ['createdby' => $id, 'class_key' => 'msProduct']);
        foreach ($products as $product) {
            $this->productService->removeProduct($product->get('id'));
        }
    }

    public function getUserFields()
    {
        $fields = [
            'active' => 'Активен',
            'email' => 'Email',
            'phone' => 'Телефон',
            'dob' => 'Дата рождения',
            'address' => 'Адрес для корреспонденции',
            'zip' => 'Индекс для корреспонденции',
            'comment' => 'Причина отклонения',
            'card_data' => 'Платёжные реквизиты',
            'pass_where' => 'Орган, выдавший паспорт',
            'pass_code' => 'Код подразделения',
            'pass_address' => 'Адрес регистрации',
            'offer' => 'Оферта принята',
            'surname' => 'Фамилия',
            'name' => 'Имя',
            'fathername' => 'Отчество',
            'certificate_num' => 'Номер справки самозанятого',
            'certificate_date' => 'Дата выдачи справки самозанятого',
            'insurance' => 'Номер СНИЛС',
            'address_ip' => 'Адрес регистрации ИП',
            'ogrnip' => 'ОГРНИП',
            'rs' => 'Расчетный счет',
            'bik' => 'БИК',
        ];

        $fields = array_merge($this->getExtraFields(), $fields);
        return [
            'Общие' => [
                'profile_num' => $fields['profile_num'],
                'status' => $fields['status'],
                'active' => $fields['active'],
                'offer' => $fields['offer'],
                'comment' => $fields['comment'],
                'old_id' => $fields['old_id'],
            ],
            'Личные данные' => [
                'surname' => $fields['surname'],
                'name' => $fields['name'],
                'fathername' => $fields['fathername'],
                'email' => $fields['email'],
                'phone' => $fields['phone'],
                'dob' => $fields['dob'],
                'insurance' => $fields['insurance'],
            ],
            'Адреса' => [
                'zip' => $fields['zip'],
                'address' => $fields['address'],
                'zip_fact' => $fields['zip_fact'],
                'address_fact' => $fields['address_fact'],
            ],
            'Паспортные данные' => [
                'pass_num' => $fields['pass_num'],
                'pass_series' => $fields['pass_series'],
                'pass_where' => $fields['pass_where'],
                'pass_code' => $fields['pass_code'],
                'pass_address' => $fields['pass_address'],
            ],
            'Данные об ИП и самозанятости' => [
                'legal_form' => $fields['legal_form'],
                'ogrnip' => $fields['ogrnip'],
                'address_ip' => $fields['address_ip'],
                'certificate_num' => $fields['certificate_num'],
                'certificate_date' => $fields['certificate_date'],
            ],
            'Платёжные данные' => [
                'card_data' => $fields['dob'],
                'rs' => $fields['rs'],
                'bik' => $fields['bik'],
            ],
        ];
    }

    public function getExtraFields()
    {
        $extrafields = [];
        $q = $this->modx->newQuery('ExtraUserField');
        $q->select('name, label');
        $tstart = microtime(true);
        if ($q->prepare() && $q->stmt->execute()) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            $result = $q->stmt->fetchAll(\PDO::FETCH_ASSOC);
            foreach ($result as $item) {
                $extrafields[$item['name']] = $item['name'] === 'status' ? 'Статус' : $item['label'];
            }
        }
        return $extrafields;
    }

    public function removeDir(string $dir): void
    {
        if (is_dir($dir)) {
            $objects = scandir($dir);
            foreach ($objects as $object) {
                if ($object != "." && $object != "..") {
                    if (is_dir($dir . $object) && !is_link($dir . $object)) {
                        $this->removeDir($dir . $object);
                    } else {
                        if (file_exists($dir . $object)) {
                            unlink($dir . $object);
                        }
                    }
                }
            }
            if (file_exists($dir) && is_dir($dir)) {
                rmdir($dir);
            }
        }
    }
}