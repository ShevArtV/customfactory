<!--##{"templatename":"Продукция","pagetitle":"Страница категории","icon":"icon-list", "extends": "12"}##-->

<!-- /usr/local/php/php-7.4/bin/php /home/host1860015/art-sites.ru/htdocs/customfactory/core/components/migxpageconfigurator/console/mgr_tpl.php web category.tpl -->

<div id="{$id}" data-mpc-section="product_templates" data-mpc-name="Продукция">
    <div class="container-medium">
        <div class="page" data-mpc-field="content">
            Выберите товар, для которого будете делать дизайн.
            Перейдите в карточку товара и скачайте шаблон. Сделайте
            свой уникальный дизайн товара. Загрузите готовые файлы
            в сервис и начните продавать.
        </div>
    </div>

    <!--filter-->
    <form data-si-form data-si-event="change" data-si-preset="default_products" class="filter">
        <div class="filter-column">
            <div class="filter-item">
                <ul class="filter-list">
                    <li>
                        <div class="filter-name filter-name--select" data-popup-link="filter-parent">
                            Категории
                        </div>
                        <div class="popup-menu popup-menu--checked" data-popup="filter-parent">
                            <ul class="filter-value-list scrollbar">
                                {set $categories = $_modx->runSnippet('@FILE snippets/product/snippet.getparents.php')}
                                {foreach $categories as $id => $caption}
                                    <li>
                                        <label class="checkbox-label">
                                            <input class="checkbox" type="checkbox" name="parent[]" value="{$id}">
                                            <span class="checkbox-text checkbox-text--small">{$caption}</span>
                                        </label>
                                    </li>
                                {/foreach}
                            </ul>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
        <div class="filter-column">
            <div class="filter-item">
                <div class="filter-name">
                    Сортировать:
                    <div class="js-custom-select">
                        {set $statuses = ('statuses' | placeholder)}
                        <select class="" name="sortby">
                            <option value="Product.id|ASC" selected>По умолчанию</option>
                            <option value="Data.price|DESC">Больше вознаграждение</option>
                            <option value="Data.price|ASC">Меньше вознаграждение</option>
                            <option value="Data.new|DESC">Новинки</option>
                            <option value="Data.popular|DESC">Бестселлеры</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <div data-results>
        {$_modx->runSnippet('@FILE snippets/product/snippet.getdefaultproducts.php')}
        <div data-mpc-unwrap="1" data-mpc-remove="1" data-mpc-chunk="getdefaultproducts/default/item.tpl">
            {foreach $categories as $name => $products}
                <div class="offset-top offset-top--small">
                    <h2>{$name}</h2>
                    <div class="columns">
                        {foreach $products as $p}
                            <div class="column col-3 lg-col-4 sm-col-6">
                                <a href="{$p.uri}" class="element">
                                    {if $p.new}
                                        <div class="element-label">Новинка</div>
                                    {/if}
                                    {if $p.popular}
                                        <div class="element-label">Бестселлер</div>
                                    {/if}
                                    <div class="element-image">
                                        <img src="{$p.img}" alt="">
                                    </div>
                                    <div class="element-content">
                                        <div class="element-title">{$p.pagetitle}</div>
                                        <div class="element-info">Вознаграждение {$p.price}&nbsp;₽</div>
                                    </div>
                                </a>
                            </div>
                        {/foreach}
                    </div>
                </div>
            {/foreach}
        </div>
    </div>


</div>

<div id="{$id}" data-mpc-section="our_tg" data-mpc-name="Наш Telegram" data-mpc-static="1" class="offset-top" data-mpc-copy="lk_main.tpl"></div>