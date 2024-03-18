<div id="{$id}" class="reviews offset grey-section">
    <div class="container">
        <div class="layout">
            <div class="layout-aside">
                <div class="layout-aside__title red">{$title}</div>
            </div>
            <div class="layout-content">
                <h2>{$subtitle}</h2>

                <div>{foreach $list_triple_img as $item1 index=$i last=$l}
                    <div class="reviews-item">
                        <div class="reviews-item__aside">
                            <div class="reviews-item__avatar">
                                <img src="assets/components/migxpageconfigurator/images/fake-img.png" alt="{($item1.title?:$item1.content) | notags}" data-lazy="{$item1.img}">
                            </div>
                            <div class="reviews-item__name">{$item1.title}</div>
                        </div>
                        <div class="reviews-item__content">
                            <div class="reviews-item__title">{$item1.subtitle}</div>
                            <div class="reviews-item__text">{$item1.content}</div>
                        </div>
                    </div>{/foreach}
                    </div>
            </div>
        </div>
    </div>
</div>