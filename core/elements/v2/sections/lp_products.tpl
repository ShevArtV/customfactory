<div id="{$id}" class="gradient-section item-section offset">
    <div class="container">
        <div class="layout">
            <div class="layout-aside">
                <div class="layout-aside__title">{$title}</div>
            </div>
            <div class="layout-content">{$subtitle}</div>
        </div>

        <div class="offset-top">
            <div class="columns">##'pdoResources' | snippet: [
                        'parents' => '13',
'showUnpublished' => '1',
'where' => '{ "class_key":"msCategory"}',
'tpl' => '@FILE chunks/pdoresources/main_categories/item.tpl',
'includeTVs' => 'img,is_hit,show_on_main',
'tvFilters' => 'show_on_main==1',
'tvPrefix' => '',
'sortby' => '{ "menuindex":"ASC"}',
'limit' => '5',
]}</div>
        </div>
    </div>
</div>