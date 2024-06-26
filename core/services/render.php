<?php

namespace CustomServices;

class Render
{

    /** @var \modX */
    private \modX $modx;

    /** @var \pdoTools */
    private \pdoTools $pdoTools;

    public function __construct(\modX $modx)
    {
        $this->modx = $modx;
        $this->pdoTools = $this->modx->getParser()->pdoTools;
    }

    public function getFAQ(?array $data = [], ?array $props = []): string
    {
        if (!$this->pdoTools) {
            $this->modx->log(1, 'No pdoTools');
        }
        if (empty($data)) {
            return '';
        }

        ['navItemTpl' => $navItemTpl, 'questionTpl' => $questionTpl, 'tabTpl' => $tabTpl, 'wrapTpl' => $wrapTpl] = $props;
        $faq = [];
        $nav = '';
        $tabs = '';
        $questions = '';
        $tabNum = 0;

        foreach ($data as $item) {
            if ($props['rid'] !== 51972) {
                $faq[$item['type']][] = $item;
            } else {
                $faq['all'][] = $item;
            }
        }

        $typeNames = [
            'all' => '',
            'self-employment' => 'Самозанятость',
            'design' => 'Дизайн',
            'income' => 'Доход',
        ];

        foreach ($faq as $type => $items) {
            $active = false;
            if ($tabNum === 0) {
                $active = true;
            }
            $tabNum++;
            if ($props['rid'] !== 51972) {
                $nav .= $this->pdoTools->getChunk($navItemTpl, ['active' => $active, 'type' => $type, 'typeName' => $typeNames[$type]]);
            }
            $questions = '';
            foreach ($items as $item) {
                $questions .= $this->pdoTools->getChunk($questionTpl, $item);
            }
            $tabs .= $this->pdoTools->getChunk($tabTpl, ['questions' => $questions, 'active' => $active, 'type' => $type]);
        }

        return $this->pdoTools->getChunk($wrapTpl, ['nav' => $nav, 'tabs' => $tabs]);
    }
}
