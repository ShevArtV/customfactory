<?php

return [
    'designs' => [
        'configId' => 2,
        'wrapper' => '#/fffiltering/designs/ffform.tpl',
        'defaultTplOuter' => '#/fffiltering/designs/fffcheckboxgroupouter.tpl',
        'defaultTplRow' => '#/fffiltering/designs/ffcheckboxgroup.tpl',
        'createdonTplOuter' => '',
        'createdonTplRow' => '',
        'categories' => '$parents',
        'types' => '$types',
        'presetName' => 'flatfilters'
    ],
    'designers' => [
        'configId' => 1,
        'presetName' => 'flatfilters',
        'wrapper' => '#/fffiltering/designers/ffform.tpl',
        'defaultTplOuter' => '#/fffiltering/designers/ffselect.tpl',
        'defaultTplRow' => '#/fffiltering/designers/ffoption.tpl',
        'legal_formTplOuter' => '#/fffiltering/designers/ffselectlegal.tpl',
        'legal_formTplRow' => '#/fffiltering/designers/ffoptionlegal.tpl',
        'offerTplOuter' => '#/fffiltering/designers/ffselectoffer.tpl',
        'offerTplRow' => '#/fffiltering/designers/ffoptionoffer.tpl',
    ],
    'orders' => [
        'extends' => 'fffiltering.designs',
        'configId' => 4,
        'wrapper' => '#/fffiltering/orders/outer.tpl',
        'dateTplOuter' => '',
        'dateTplRow' => '',
        'element' => '@FILE snippets/product/snippet.renderorders.php',
    ],
];
