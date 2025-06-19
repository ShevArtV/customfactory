<div>
    ##set $popular = 'msProducts' | snippet: [
                        'parents' => '13',
'tpl' => '@FILE chunks/msproducts/popular/item.tpl',
'limit' => '0',
'includeTVs' => 'img',
'tvPrefix' => '',
'templates' => '14',
'where' => '{ "Data.popular":1}',
'toPls' => 'popular',
]}
    
    ##if $popular}
    <div class="offset-top">
        <h2>{$title?:'Популярные товары'}</h2>

        <div class="columns">
            ##$popular}
        </div>
    </div>
    ##/if}
</div>