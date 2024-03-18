<div id="{$id}" class="advantages grey-section">
    <div class="container">
        <div class="advantages-row">##foreach $list_double as $item1 index=$i last=$l}
                    <div class="advantages-item">
                <div class="advantages-item__title">##$item1.title}</div>
                <div class="advantages-item__text">##$item1.content}</div>
            </div>##/foreach}
                    </div>

        <div class="layout">
            <div class="layout-aside">
                <div class="layout-aside__title">##$title}</div>
            </div>
            <div class="layout-content">
                <div class="advantages-content">
                    <h2>##$subtitle}</h2>
                    <div class="layout-text advantages-content__text">##$content}</div>
                </div>
            </div>
        </div>

    </div>
</div>