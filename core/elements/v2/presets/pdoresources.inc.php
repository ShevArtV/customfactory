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
        'includeContent' => 1,
        'tvPrefix' => '',
        'sortby' => ['menuindex' => 'ASC']
    ],
    'help_aside_short' => [
        'extends' => 'pdoresources.help_aside',
        'resources' => '51973,51974',
    ],
    'footer_contacts' => [
        'parents' => 51971,
        'resources' => '54757,51974',
        'tpl' => '#/pdoresources/footer_contacts/item.tpl',
        'where' => ['class_key' => 'modWebLink'],
        'includeContent' => 1,
        'sortby' => ['menuindex' => 'ASC']
    ],
    'legal_info' => [
        'parents' => 2,
        'tpl' => '#/pdoresources/legal_info/item.tpl',
        'where' => ['hidemenu:!=' => 1],
        'sortby' => ['menuindex' => 'ASC']
    ],
    'footer_nav' => [
        'parents' => 0,
        'resources' => '51982,54748,54752,54757,51972',
        'tpl' => '#/pdoresources/footer_nav/item.tpl',
    ]
];