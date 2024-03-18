<div id="{$id}" class="showcase">
    <div class="container">
        <div class="showcase-layout">
            <div class="showcase-layout__content">
                <h1 class="showcase-title">{$title}</h1>
                <div class="showcase-text">{$subtitle}</div>
                <img alt="{($title?:$content) | notags}" width="{$img_w}" height="{$img_h}" class="showcase-image" src="assets/components/migxpageconfigurator/images/fake-img.png" data-lazy="{set $params = 'w='~$img_w~'&h='~$img_h~'&zc=1&ra=1&bg=&f=png'}{$img | pThumb:$params}">
                <div class="showcase-button">
                    <a href="{$target}" class="btn">
                       {$btn_text}
                    </a>
                </div>
                <div class="showcase-advantages">
                    <ul>{foreach $list_simple as $item1 index=$i last=$l}
                    <li>{$item1.content}</li>{/foreach}
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>