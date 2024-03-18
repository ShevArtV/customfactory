<?php

return [
    'default' => [
        'tplChar' => '#/gettagsbyalphabet/char.tpl',
        'tplTag' => '#/gettagsbyalphabet/tag.tpl',
        'tplEmpty' => '#/gettagsbyalphabet/empty.tpl',
    ],
    'product' => [
        'extends' => 'gettagsbyalphabet.default',
        'tplTag' => '#/gettagsbyalphabet/tag_product.tpl',
        'pid' => '$id',
        'tag' => '$tags[0]'
    ]
];