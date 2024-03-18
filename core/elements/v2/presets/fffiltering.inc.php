<?php

return [
    'designers' => [
        'configId' => 1,
        'limit' => 4,

        'wrapper' => '#/fffiltering/designers/ffouter.tpl',
        'empty' => '#/fffiltering/designers/ffempty.tpl',
        'defaultTplOuter' => '#/fffiltering/designers/ffselect.tpl',
        'defaultTplRow' => '#/fffiltering/designers/ffoption.tpl',
        'legal_formTplOuter' => '#/fffiltering/designers/ffselectlegal.tpl',
        'legal_formTplRow' => '#/fffiltering/designers/ffoptionlegal.tpl',
        'offerTplOuter' => '#/fffiltering/designers/ffselectoffer.tpl',
        'offerTplRow' => '#/fffiltering/designers/ffoptionoffer.tpl',
        'tpl' => '#/fffiltering/designers/item.tpl',

        'sortby' => ['Profile.createdon' => 'DESC'],
        'element' => 'pdoUsers',
    ],
    'designs' => [
        'configId' => 2,
        'limit' => 6,

        'wrapper' => '#/fffiltering/designs/ffouter.tpl',
        'empty' => '#/fffiltering/designs/ffempty.tpl',
        'defaultTplOuter' => '#/fffiltering/designs/fffcheckboxgroupouter.tpl',
        'defaultTplRow' => '#/fffiltering/designs/ffcheckboxgroup.tpl',
        'createdonTplOuter' => '',
        'createdonTplRow' => '',
        'tpl' => '#/fffiltering/designs/item.tpl',

        'sortby' => ['createdon' => 'DESC'],
        //'element' => 'msProducts',
    ]
];