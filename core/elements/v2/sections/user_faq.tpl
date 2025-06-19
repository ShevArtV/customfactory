<div id="{$id}">
    ##if ('user_allow_add' | placeholder) || $_modx->resource.template !== 12}
    <div class="page-layout offset-top">
        <div class="page-layout__content container-medium">

            <div class="head">
                <div class="head-title">##$title}</div>
                {if $resource.template !== 24}
                    <div class="head-more">
                        <a href="##$target | resource: 'uri'}">##$btn_text}</a>
                    </div>
                {/if}
            </div>

            <div class="page">##$subtitle}</div>
            <div data-tab-wrapper>##'getFAQ' | snippet: [
                        'data' => $list_faq,
'rid' => $_modx->resource.id,
'wrapTpl' => '@FILE chunks/getfaq/default/wrap.tpl',
'navItemTpl' => '@FILE chunks/getfaq/default/nav_item.tpl',
'tabTpl' => '@FILE chunks/getfaq/default/tab.tpl',
'questionTpl' => '@FILE chunks/getfaq/default/item.tpl',
]}</div>

            
        </div>

        <div class="page-layout__aside">##'pdoResources' | snippet: [
                        'parents' => '51971',
'tpl' => '@FILE chunks/pdoresources/help_aside/item.tpl',
'resources' => '51973,51974',
'includeTVs' => 'img',
'includeContent' => '1',
'tvPrefix' => '',
'sortby' => '{ "menuindex":"ASC"}',
'extends' => 'pdoresources.help_aside',
]}</div>
    </div>
    ##/if}
</div>