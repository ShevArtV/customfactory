<?php
// /usr/local/php/php-7.4/bin/php -d display_errors -d error_reporting=E_ALL /home/host1860015/art-sites.ru/htdocs/customfactory/core/components/migxpageconfigurator/console/mgr_elems.php snippet

return [
    'getFAQ' => [
        'file' => 'render/snippet.getfaq',
        'description' => 'выводит список ЧАВО',
        'categoryName' => 'Вспомогательные',
        'static' => 1,
        'properties' => []
    ],
    'getTagByAlphabet' => [
        'file' => 'product/snippet.gettagbyalphabet',
        'description' => 'выводит список тегов с разбивкой по первым буквам',
        'categoryName' => 'Вспомогательные',
        'static' => 1,
        'properties' => []
    ],
    'prepareFiles' => [
        'file' => 'designer/hook.preparefiles',
        'description' => 'подготавливает файлы к сохранению',
        'categoryName' => 'Хуки',
        'static' => 1,
        'properties' => []
    ],
];