<?php

return [
    'popular' => [
        'parents' => 15,
        'tpl' => '#/msproducts/popular/item.tpl',
        'limit' => 0,
        'includeTVs' => 'img',
        'tvPrefix' => '',
        'templates' => 14,
        'where' => ['Data.popular' => 1],
        'toPls' => 'popular'
    ]
];