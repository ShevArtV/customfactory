<?php

// /usr/local/php/php-7.4/bin/php -d display_errors -d error_reporting=E_ALL /home/host1860015/art-sites.ru/htdocs/customfactory/core/components/migxpageconfigurator/console/mgr_elems.php tv

return [
    'is_hit' => [
        'type' => 'checkbox',
        'caption' => 'Хит продаж',
        'description' => '',
        'category' => 'Отображение',
        'input_properties' => [],
        'elements' => 'Да==1',
        'templates' => [
            'Продукция'
        ],
    ],
    'workflow' => [
        'type' => 'migx',
        'caption' => 'Доработка',
        'description' => '',
        'category' => 'Вспомогательные',
        'input_properties' => [
            'configs' => 'workflow',
        ],
        'templates' => [
            'Товар',
        ],
    ],
];