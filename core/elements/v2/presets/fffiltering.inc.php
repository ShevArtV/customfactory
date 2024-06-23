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
        'element' => '@FILE snippets/designer/snippet.getusers.php',
    ],
    'designs' => [
        'configId' => 2,
        'limit' => 12,
        'hooks' => '',
        'wrapper' => '#/fffiltering/designs/ffouter.tpl',
        'empty' => '#/fffiltering/designs/ffempty.tpl',
        'defaultTplOuter' => '#/fffiltering/designs/fffcheckboxgroupouter.tpl',
        'defaultTplRow' => '#/fffiltering/designs/ffcheckboxgroup.tpl',
        'createdonTplOuter' => '',
        'createdonTplRow' => '',
        'tpl' => '#/fffiltering/designs/item.tpl',

        'sortby' => ['Resource.id' => 'DESC'],
        'element' => '@FILE snippets/product/snippet.render.php',
        'categories' => '$parents',
        'types' => '$types',
    ],
    'products' => [
        'extends' => 'fffiltering.designs',
        'limit' => 6,
        'tpl' => '#/fffiltering/products/item.tpl',
    ],
    'orders' => [
        'configId' => 4,
        'limit' => 6,
        'extends' => 'fffiltering.designs',
        'wrapper' => '#/fffiltering/orders/outer.tpl',
        'empty' => '#/fffiltering/orders/ffempty.tpl',
        'tpl' => '#/fffiltering/orders/item.tpl',
        'dateTplOuter' => '',
        'dateTplRow' => '',
        'element' => '@FILE snippets/product/snippet.renderorders.php',
        'sortby' => ['Resource.createdon' => 'DESC'],
    ]
];
