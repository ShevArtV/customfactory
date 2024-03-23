<?php

return [
    'main' => [
        'parents' => 27,
        'level' => 2,
        'resources' => '$resources',
        'tplOuter' => '#/pdomenu/tplOuter.tpl',
        'tpl' => '#/pdomenu/tpl.tpl',
        'tplParentRow' => '#/pdomenu/tplParentRow.tpl',
        'tplInner' => '@INLINE {$wrapper}',
        'tplInnerRow' => '#/pdomenu/tplInnerRow.tpl',
    ]
];