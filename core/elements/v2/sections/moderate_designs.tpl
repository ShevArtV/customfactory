<div id="{$id}">
    <div class="container-medium">
        <div class="page input-group">{$content}</div>
    </div>

    ##'!ffFiltering' | snippet: [
                        'configId' => '2',
'limit' => '6',
'wrapper' => '@FILE chunks/fffiltering/designs/ffouter.tpl',
'empty' => '@FILE chunks/fffiltering/designs/ffempty.tpl',
'defaultTplOuter' => '@FILE chunks/fffiltering/designs/fffcheckboxgroupouter.tpl',
'defaultTplRow' => '@FILE chunks/fffiltering/designs/ffcheckboxgroup.tpl',
'createdonTplOuter' => '',
'createdonTplRow' => '',
'tpl' => '@FILE chunks/fffiltering/designs/item.tpl',
'sortby' => '{ "createdon":"DESC"}',
'element' => 'msProducts',
]}
</div>