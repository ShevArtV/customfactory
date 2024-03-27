<!--##{"templatename":"Товар Админа","pagetitle":"Страница Товара Админа","icon":"icon-star", "extends": "12"}##-->

<!-- /usr/local/php/php-7.4/bin/php /home/host1860015/art-sites.ru/htdocs/customfactory/core/components/migxpageconfigurator/console/mgr_tpl.php web admin_product.tpl -->
<!-- php7.4 www/core/components/migxpageconfigurator/console/mgr_tpl.php web admin_product.tpl -->

<!--card-->
<div id="{$id}" data-mpc-section="product_card" data-mpc-name="Карточка товара" class="card">

    <div class="card-image">
        <img src="{$resource.tvs.img | pThumb: 'w=398&h=345&zc=1'}" alt="" width="398" height="345">
    </div>

    <div class="card-content">
        <h1>{$resource.pagetitle}</h1>

        <div class="card-price">
            Вознаграждение с продажи: <span class="red">{$resource.price} ₽</span>
        </div>

        <div class="btn-group">
            {if $resource.tvs.tplfile}
            <a href="{$resource.tvs.tplfile}" download class="btn">Скачать файл шаблона</a>
            {/if}
            ##set $allow_add = $_modx->getPlaceholder('user_allow_add')}
            <a href="{51982 | url}?parent={$resource.parent}&type={$resource.id}" class="btn btn--line ##!$allow_add ? 'disabled': ''}">Загрузить дизайн</a>
        </div>

    </div>

</div>

<!--Примеры дизайнов подушек-->
<div data-mpc-section="design_examples" data-mpc-name="Примеры дизайнов" class="offset-top offset-top--small">
    <div class="head">
        <div class="head-title" data-mpc-field="title">Примеры дизайнов подушек</div>
    </div>

    <div class="container-small">
        <div class="page" data-mpc-field="subtitle">
            Посмотрите примеры популярных дизайнов этого продукта, которые хорошо продаются на Оzon, WB, ЯндексМаркет
        </div>
    </div>

    <div class="columns" data-mpc-field="list_simple_img">
        <div class="column col-2-5 xl-col-3 lg-col-4 sm-col-6" data-mpc-item>
            <div class="preview-element">
                <img data-mpc-field-1="img" src="assets/project_files/v2/img/preview-element-1.jpg" alt="">
            </div>
        </div>
    </div>

</div>

<!--Обязательные технические требования к макету-->
<div data-mpc-section="technical_demands" data-mpc-name="Технические требования" class="offset-top offset-top--small">
    <div class="head">
        <div class="head-title" data-mpc-field="title">Обязательные технические требования к макету</div>
    </div>

    <div class="container-medium">

        <ul class="requirements-list" data-mpc-field="list_double">
            <li data-mpc-item>
                <h3 data-mpc-field-1="title">Печатное поле, размер макета и готового изделия</h3>
                <span data-mpc-field-1="content">
                    Печатное поле подушки 300×300 мм. Рисунок не должен выходить за эти границы, потому что он не напечатается или напечатается с искажениями из-за особенностей технологии
                производства.Размер макета для печати — 440×440 мм. То есть вы должны загрузить макет размером 440×440 мм с расположенным в нём по центру изображением 300×300 мм. Макеты с
                запечаткой «в края» не принимаются. Реальный размер готовой подушки — 400×400 мм. Пост в нашем телеграмм-канале о <a href="">нюансах работы с печатным полем подушки</a>.
                </span>
            </li>
        </ul>

    </div>

</div>

<!--Популярные товары-->
<div data-mpc-section="popular_products" data-mpc-name="Популярные товары">
    <div data-mpc-unwrap="1" data-mpc-snippet="msProducts|popular"></div>
    ##if $popular}
    <div class="offset-top">
        <h2 data-mpc-field="title">Популярные товары</h2>

        <div class="columns">
            ##$popular}
        </div>
    </div>
    ##/if}
</div>
