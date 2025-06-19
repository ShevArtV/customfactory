<div id="{$id}">
    <div class="container-medium">
        <div class="page">{$content}</div>
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
        
    </div>


</div>