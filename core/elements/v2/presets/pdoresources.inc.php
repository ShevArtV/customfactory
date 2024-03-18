<?php

return [
    'main_categories' => [
        'parents' => 13,
        'showUnpublished' => 1,
        'tpl' => '#/pdoresources/main_categories/item.tpl',
        'includeTVs' => 'img,is_hit',
        'tvPrefix' => '',
        'sortby' => ['menuindex' => 'ASC'],
        'limit' => 5
    ],
    'ident_nav' => [
        'parents' => 0,
        'resources' => '22,23',
        'tpl' => '#/pdoresources/ident_nav/item.tpl'
    ],
    'help_aside' => [
        'parents' => 51971,
        'tpl' => '#/pdoresources/help_aside/item.tpl',
        'resources' => '51972,51973,51974',
        'includeTVs' => 'img',
        'tvPrefix' => '',
        'sortby' => ['menuindex' => 'ASC']
    ],
    'help_aside_short' => [
        'extends' => 'pdoresources.help_aside',
        'resources' => '51973,51974',
    ]
];