<div id="{$id}" class="gradient-section offset">
    <div class="container">
        <div class="layout">
            <div class="layout-aside">
                <div class="layout-aside__title">{$title}</div>
            </div>
            <div class="layout-content">
                <h2>{$subtitle}</h2>
                <div>{foreach $list_triple_picture as $item1 index=$i last=$l}
                    <div class="benefits-item">
                        
                        <div class="benefits-layout {$item1.subtitle}">
                            <div class="benefits-layout__content">
                                <h4>{$item1.title}</h4>
                                <span>{$item1.content}</span>
                            </div>
                            <div class="benefits-layout__image">
                                <picture class="shadow radius">{$item1.picture}</picture>
                            </div>
                        </div>
                    </div>{/foreach}
                    </div>
            </div>
        </div>
    </div>
</div>