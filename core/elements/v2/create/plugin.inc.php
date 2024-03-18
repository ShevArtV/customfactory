<?php
// /usr/local/php/php-7.4/bin/php -d display_errors -d error_reporting=E_ALL /home/host1860015/art-sites.ru/htdocs/customfactory/core/components/migxpageconfigurator/console/mgr_elems.php plugin
return [
    'router' => [
        'file' => 'plugin.router',
        'description' => '',
        'categoryName' => 'Вспомогательные',
        'events' => [
            'OnLoadWebDocument' => [],
            'OnBeforeDocFormSave' => [],
            'OnDocFormSave' => [],
            'OnBeforeFileValidate' => [],
        ],
    ],
];