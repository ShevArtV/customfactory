<div id="{$id}" class="offset-top">
    <div class="container">
        <div class="layout">
            <div class="layout-aside">
                <div class="layout-aside__title red">{$title}</div>
            </div>
            <div class="layout-content">
                <h2>{$subtitle}</h2>

                <div class="work-items">{foreach $list_double_img as $item1 index=$i last=$l}
                    <div class="work-item">
                        <div class="work-item__aside">
                            <div class="work-item__icon">
                                <img src="assets/components/migxpageconfigurator/images/fake-img.png" alt="{($item1.title?:$item1.content) | notags}" width="{$item1.img_w}" height="{$item1.img_h}" data-lazy="{$item1.img}">
                            </div>
                        </div>
                        <div class="work-item__content">
                            <div class="work-item__title">{$item1.title}</div>
                            <div class="work-item__text">{$item1.content}</div>
                        </div>
                    </div>{/foreach}
                    </div>
            </div>
        </div>
    </div>
</div>