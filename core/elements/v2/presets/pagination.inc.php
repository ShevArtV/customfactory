<?php

return [
    'designs' => [
        'configId' => 2,
        'render' => '@FILE snippets/product/snippet.render.php',

        'snippet' => '!Pagination',
        'presetName' => '$presetName',
        'pagination' => 'filters',
        'resultBlockSelector' => '[data-pn-result="filters"]',
        'resultShowMethod' => 'insert',
        'hashParams' => 'filtersHash,sortby',
        'noDisabled' => 1,
        'getDisabled' => 0,

        'limit' => 12,
        'parents' => 13,
        'sortby' => ['Resource.id' => 'DESC'],
        'tpl' => '#/fffiltering/designs/item.tpl',
        'tplEmpty' => '#/fffiltering/designs/ffempty.tpl',
    ],
    'products' => [
        'extends' => 'pagination.designs',
        'limit' => 6,
        'tpl' => '#/fffiltering/products/item.tpl',
    ],
    'designers' => [
        'extends' => 'pagination.designs',

        'configId' => 1,
        'render' => '@FILE snippets/designer/snippet.getusers.php',
        'tplEmpty' => '#/fffiltering/designers/ffempty.tpl',
        'tpl' => '#/fffiltering/designers/item.tpl',
        'limit' => 4,
        'parents' => '',
        'sortby' => ['Profile.createdon' => 'DESC'],
    ],
    'orders' => [
        'extends' => 'pagination.designs',

        'configId' => 4,
        'render' => '@FILE snippets/product/snippet.renderorders.php',
        'tplEmpty' => '#/fffiltering/orders/ffempty.tpl',
        'tpl' => '#/fffiltering/orders/item.tpl',
        'limit' => 6,
        'parents' => '',
        'sortby' => ['Order.createdon' => 'DESC'],
    ]

];
