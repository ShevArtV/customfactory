<?php

namespace CustomServices;

require_once dirname(__FILE__, 2) . '/vendor/autoload.php';

use \PhpOffice\PhpSpreadsheet\Spreadsheet;
use \PhpOffice\PhpSpreadsheet\Writer\Xlsx;

class Report extends Base
{
    /** @var string $className */
    private string $className;

    /** @var string $filename */
    private string $filename;

    /** @var string $file */
    private string $file;

    /** @var array $names */
    private array $names;

    /** @var array $captions */
    private array $captions;

    /** @var array $headers */
    private array $headers;

    /** @var array $ids */
    private array $ids;

    /** @var array $sizes */
    private array $sizes;

    /** @var array $tshirtParents */
    private array $tshirtParents;

    /** @var array $statuses */
    private array $statuses;

    /** @var array $types */
    private array $types;

    /** @var array $parents */
    private array $parents;

    protected function initialize()
    {
        parent::initialize();
        $this->statuses = $this->getStatuses();
        $this->sizes = ['M', 'L', 'XL', 'XXL'];
        $this->tshirtParents = [69138789, 6914097897];
        $this->filename = 'report-' . date('d-m-Y-H-i-s');
        $this->setProductTypes();
        $this->setParents();
    }

    private function setProductTypes()
    {
        $products = $this->getProductTypes();
        foreach ($products as $p) {
            $this->types[$p['id']] = $p['pagetitle'];
        }
    }

    private function setParents()
    {
        $parents = $this->getParents();
        foreach ($parents as $p) {
            $this->parents[$p['id']] = $p['pagetitle'];
        }
    }

    public function generate(array $data)
    {
        $this->className = $data['className'];
        $this->ids = $data['ids'] ?? $_SESSION['flatfilters'][$data['configId']]['rids'] ? explode(',', $_SESSION['flatfilters'][$data['configId']]['rids']) : [];
        $this->names = !is_array($data['names']) ? json_decode($data['names'], true) : $data['names'];
        $this->captions = !is_array($data['captions']) ? json_decode($data['captions'], true) : $data['captions'];
        $this->setFileHeaders();
        $fileData = array_merge($this->headers, $this->getFileData());
        return $this->createFile($fileData);
    }

    public function setFileHeaders(): void
    {
        $i = 1;
        foreach ($this->captions as $caption) {
            $index = $this->getColumnIndex($i);
            $this->headers[$index . '1'] = $caption[0];
            $i++;
        }
    }

    public function getColumnIndex(int $number, string $index = '')
    {
        $c = $number / 26;
        if ($c > 1) {
            $index .= $this->getColumnIndex($c, $index);
            $number = $number - floor($c) * 26;
        }
        return $index . chr($number + 64);
    }

    public function getFileData(): array
    {
        $output = [];
        $q = $this->modx->newQuery($this->className);

        if ($this->className === 'modUser') {
            $q->leftJoin('modUserProfile', 'Profile');
            $q->select($this->modx->getSelectColumns('modUser', 'modUser', '', ['modUser.primary_group', 'id']));
            $q->select($this->modx->getSelectColumns('modUserProfile', 'Profile', '', ['id', 'sessionid'], true));
            if (!empty($this->ids)) {
                $q->where(['modUser.id:IN' => $this->ids]);
            } else {
                $q->where(['modUser.primary_group' => 2]);
            }
        }
        if ($this->className === 'msProduct') {
            $q->leftJoin('msProductData', 'Data');
            $q->select($this->modx->getSelectColumns('msProduct', 'msProduct', '', ['parent', 'id', 'content', 'pagetitle']));
            $q->select($this->modx->getSelectColumns('msProductData', 'Data', '', ['id'], true));
            if (!empty($this->ids)) {
                $q->where(['msProduct.id:IN' => $this->ids]);
            } else {
                $q->where(['msProduct.template' => 13]);
            }
        }

        $strNum = 1;
        $tstart = microtime(true);
        if ($q->prepare() && $q->stmt->execute()) {
            $this->modx->queryTime += microtime(true) - $tstart;
            $this->modx->executedQueries++;
            $resources = $q->stmt->fetchAll(\PDO::FETCH_ASSOC);

            foreach ($resources as $resource) {
                if ($this->className === 'modUser') {
                    $strNum++;
                    $output = array_merge($output, $this->getUserData($resource, $strNum));
                }
                if ($this->className === 'msProduct') {
                    if (in_array($resource['parent'], $this->tshirtParents)) {
                        for ($i = 0; $i < 4; $i++) {
                            $strNum++;
                            $output = array_merge($output, $this->getProductData($resource, $strNum, $i));
                        }
                    } else {
                        $strNum++;
                        $output = array_merge($output, $this->getProductData($resource, $strNum));
                    }
                }
            }
        }

        return $output;
    }

    public function getUserData(array $resourceData, int $strNum): array
    {
        $extended = is_array($resourceData['extended']) ? $resourceData['extended'] : json_decode($resourceData['extended'], true);
        unset($resourceData['extended']);
        $resourceData = array_merge($resourceData, $extended);
        $output = [];
        foreach ($this->names as $i => $name) {
            $index = $this->getColumnIndex($i + 1) . $strNum;
            $output[$index] = $name === 'dob' ? date('d.m.Y', $resourceData[$name]) : $resourceData[$name];
            if ($name === 'status') {
                $output[$index] = str_replace('&nbsp;', '', $this->statuses['designer'][$resourceData['status']]['caption']);
            }
        }
        return $output;
    }

    public function getProductData(array $resourceData, int $strNum, int $i = 0): array
    {
        $output = [];
        foreach ($this->names as $i => $name) {
            $index = $this->getColumnIndex($i + 1) . $strNum;
            $output[$index] = $resourceData[$name];

            switch ($name) {
                case 'article_barcode':
                    $output[$index] = $resourceData['article'] . ' ' . $this->sizes[$i];
                    break;
                case 'article_oz':
                    if (in_array($resourceData['parent'], $this->tshirtParents)) {
                        $output[$index] = preg_replace('/^(.*)\/(.*?)-(.*)/', '\1/\2-' . $this->sizes[$i] . '-\3', $resourceData['article']);
                    }
                    break;
                case 'name_barcode':
                    $output[$index] = $this->types[$resourceData['root_id']] . ' ' . $resourceData['article'] . ' ' . $this->sizes[$i];
                    break;
                case 'status':
                    $output[$index] = str_replace('&nbsp;', '', $this->statuses['product'][$resourceData['status']]['caption']);
                    break;
                case 'root_id':
                    $output[$index] = $this->types[$resourceData['root_id']];
                    break;
                case 'parent':
                    $output[$index] = $this->parents[$resourceData['parent']];
                    break;
                case 'tags':
                case 'color':
                    $value = json_decode($resourceData[$name], true);
                    $output[$index] = is_array($value) ? implode(', ', $value) : $value;
                    break;
            }
        }
        return $output;
    }

    public function createFile(array $data): string
    {
        $spreadsheet = new Spreadsheet();
        $sheet = $spreadsheet->getActiveSheet();
        $pathToReports = MODX_ASSETS_PATH . 'reports/';
        foreach ($data as $cell => $value) {
            $sheet->setCellValue($cell, $value);
        }
        $writer = new Xlsx($spreadsheet);
        if (!is_dir($pathToReports)) {
            mkdir($pathToReports, 0755);
        }
        $filePath = MODX_ASSETS_PATH . 'reports/' . "$this->filename.xlsx";

        $writer->save($filePath);
        return 'assets/reports/' . "$this->filename.xlsx";;
    }
}