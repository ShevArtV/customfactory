<div id="{$id}" class="offset-bottom grey-section">
    <div class="container">

        <div class="joining-bnr">
            <div class="joining-bnr__aside">
                <img src="assets/components/migxpageconfigurator/images/fake-img.png" alt="{($title?:$content) | notags}" width="{$img_w}" height="{$img_h}" data-lazy="{set $params = 'w='~$img_w~'&h='~$img_h~'&zc=1&ra=1&bg=&f=png'}{$img | pThumb:$params}">
            </div>
            <div class="joining-bnr__content">{$content}</div>
        </div>

        <div class="layout">
            <div class="layout-aside">
                <div class="layout-aside__title red">{$title}</div>
            </div>
            <div class="layout-content">
                <h2>{$subtitle}</h2>

                <div class="cases-items">{foreach $list_triple_img as $item1 index=$i last=$l}
                    
                        
                        <div class="cases-title">{$item1.title}</div>
                        <!--cases-box-->
                        <div class="{$item1.subtitle}">
                            <div class="{$item1.subtitle}__image" style="background:url({$item1.img});"></div>
                            <div class="{$item1.subtitle === 'cases-item' ? 'cases-item__content' : 'cases-box__row'}">{$item1.content}</div>
                        </div>
                    {/foreach}
                    </div>
            </div>
        </div>
    </div>
</div>