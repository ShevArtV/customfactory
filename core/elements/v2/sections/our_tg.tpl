<div id="{$id}" class="offset-top">
    <div class="tg-showcase">
        <div class="tg-showcase__warp">
            <div class="tg-showcase__content">
                <div class="tg-showcase__title">##$title}</div>
                <div class="tg-showcase__text">##$content}</div>
                <ul class="tg-showcase__list">##foreach $list_simple as $item1 index=$i last=$l}
                    <li>##$item1.content}</li>##/foreach}
                    </ul>
                <div class="tg-showcase__footer">
                    <a href="##$target}" class="btn btn--full" target="_blank">
                        ##$btn_text}
                    </a>
                </div>
            </div>
            <div class="tg-showcase__image">
                <img src="assets/components/migxpageconfigurator/images/fake-img.png" alt="##($title?:$content) | notags}" loading="lazy" width="##$img_w}" height="##$img_h}" data-lazy="##set $params = 'w='~$img_w~'&h='~$img_h~'&zc=1&ra=1&bg=&f=png'}##$img | pThumb:$params}">
            </div>
        </div>
    </div>
</div>