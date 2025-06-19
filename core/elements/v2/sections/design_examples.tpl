<div class="offset-top offset-top--small">
    <div class="head">
        <div class="head-title">{$title}</div>
    </div>

    <div class="container-small">
        <div class="page">{$subtitle}</div>
    </div>

    <div class="columns">{foreach $list_simple_img as $item1 index=$i last=$l}
                    <div class="column col-2-5 xl-col-3 lg-col-4 sm-col-6">
            <div class="preview-element">
                <img src="assets/components/migxpageconfigurator/images/fake-img.png" alt="{($item1.title?:$item1.content) | notags}" data-lazy="{$item1.img}">
            </div>
        </div>{/foreach}
                    </div>

</div>