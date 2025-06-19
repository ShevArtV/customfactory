<div id="{$id}">
    <div class="container-small">
        <div class="page">{$content}</div>
    </div>

    ##set $parents = $_modx->runSnippet('@FILE snippets/product/snippet.getparents.php')}
    ##set $types = $_modx->runSnippet('@FILE snippets/product/snippet.gettypes.php')}
    ##'!ffFiltering' | snippet: [
                        'configId' => '4',
'limit' => '6',
'hooks' => '',
'wrapper' => '@FILE chunks/fffiltering/orders/outer.tpl',
'empty' => '@FILE chunks/fffiltering/orders/ffempty.tpl',
'defaultTplOuter' => '@FILE chunks/fffiltering/designs/fffcheckboxgroupouter.tpl',
'defaultTplRow' => '@FILE chunks/fffiltering/designs/ffcheckboxgroup.tpl',
'createdonTplOuter' => '',
'createdonTplRow' => '',
'tpl' => '@FILE chunks/fffiltering/orders/item.tpl',
'sortby' => '{ "Resource.createdon":"DESC"}',
'element' => '@FILE snippets/product/snippet.renderorders.php',
'categories' => $parents,
'types' => $types,
'extends' => 'fffiltering.designs',
'dateTplOuter' => '',
'dateTplRow' => '',
]}

    {include "file:chunks/common/search_modal.tpl"}
</div>