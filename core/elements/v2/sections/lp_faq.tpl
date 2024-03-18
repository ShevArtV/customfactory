<div id="{$id}" class="gradient-section offset-bottom">
    <div class="container">

        <div class="info-bnr">{$content}</div>

        <div class="layout">
            <div class="layout-aside">
                <div class="layout-aside__title">{$title}</div>
            </div>
            <div class="layout-content">
                <h2>{$subtitle}</h2>

                <div class="faq-content">{foreach $list_double as $item1 index=$i last=$l}
                    <div class="faq-item">
                        <div class="faq-item__title js-collapse-title">{$item1.title}</div>
                        <div class="faq-item__content">{$item1.content}</div>
                    </div>{/foreach}
                    </div>
            </div>
        </div>
    </div>
</div>