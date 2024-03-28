<!--##{"templatename":"Статистика продаж","pagetitle":"Страница Статистика продаж","icon":"icon-dollar","extends":"12"}##-->

<!-- /usr/local/php/php-7.4/bin/php /home/host1860015/art-sites.ru/htdocs/customfactory/core/components/migxpageconfigurator/console/mgr_tpl.php web user_orders.tpl -->
<!-- php7.4 www/core/components/migxpageconfigurator/console/mgr_tpl.php web user_orders.tpl -->
<div id="{$id}" data-mpc-section="user_orders" data-mpc-name="Статистика продаж">
    <div class="container-small">
        <div class="page" data-mpc-field="content">
            Чтобы посмотреть статистику по заказам за конкретную дату,
            выберите нужную дату и следующую за ней. Например, чтобы посмотреть
            статистику за 05.07.2023, нужно выбрать 05.07.2023 и 06.07.2023.
        </div>
    </div>

    ##set $parents = $_modx->runSnippet('@FILE snippets/product/snippet.getparents.php')}
    ##set $types = $_modx->runSnippet('@FILE snippets/product/snippet.gettypes.php')}
    <div data-mpc-unwrap="1" data-mpc-snippet="!ffFiltering|orders">
        <tr data-mpc-chunk="fffiltering/orders/ffempty.tpl">
            <td>
                <p class="page input-group">Дизайнов удовлетворяющих заданным параметрам не найдено.</p>
            </td>
        </tr>

        <div data-mpc-chunk="fffiltering/orders/outer.tpl">
            <div class="container-small">
                <!--statistic-showcase-->
                <div class="statistic-showcase">
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">
                            Всего за период <br>
                            с <span data-total="total_min">30.01.2023</span> по <span data-total="total_max">06.10.2023</span>
                        </div>
                    </div>
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Заказов:</div>
                        <div class="statistic-showcase__value"><span data-total="total_orders">0</span> шт.</div>
                    </div>
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Продаж:</div>
                        <div class="statistic-showcase__value"><span data-total="total_sales">0</span> шт.</div>
                    </div>
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Возвратов:</div>
                        <div class="statistic-showcase__value"><span data-total="total_returns">0</span> шт.</div>
                    </div>
                    <div class="statistic-showcase__item active">
                        <div class="statistic-showcase__title">Выплат:</div>
                        <div class="statistic-showcase__value"><span data-total="total_pays">0</span> ₽</div>
                    </div>
                </div>

            </div>

            <form id="filterForm" data-ff-form="filterDesignForm" class="filter">
                <input type="hidden" name="configId" value="{$configId}">

                <div class="filter-column">
                    <div class="filter-item">
                        <div class="filter-name">Дизайнов: <span id="total">{$totalResources?:0}</span></div>
                    </div>
                    <div class="filter-item">
                        <ul class="filter-list">
                            {$filters}
                        </ul>
                    </div>
                </div>
                <div class="filter-column">
                    <div class="filter-item">
                        <div class="filter-name filter-name--select" data-popup-link="datepicker">
                            {if $.get.date == ('' | period: 'week')}
                                7 дней
                            {elseif $.get.date == ('' | period: 'month')}
                                Месяц
                            {elseif $.get.date == ('' | period: 'year')}
                                Год
                            {elseif $.get.date != ''}
                                {$.get.date | replace: ',' : '-'}
                            {else}
                                Не выбрано
                            {/if}
                        </div>
                    </div>
                    <div class="filter-item filter-item--search">
                        <button type="button" class="filter-search" data-modal-show="modal-search"></button>
                    </div>
                </div>

                <!--datepicker-popup-->
                <div class="datepicker-popup js-datepicker" data-popup="datepicker">
                    <div class="datepicker-popup__layout">
                        <div class="datepicker-popup__aside">
                            <ul class="datepicker-popup__date">
                                <li data-period-week data-period-value="{'' | period: 'week'}" class="active">7 дней</li>
                                <li data-period-value="{'' | period: 'month'}">Месяц</li>
                                <li data-period-value="{'' | period: 'year'}">Год</li>
                            </ul>
                        </div>
                        <div class="datepicker-popup__content">
                            <input type="text" class="v_hidden" name="date" data-ff-filter="date" value="{$.get.date}" data-datepicker>
                        </div>
                    </div>
                    <div class="datepicker-popup__footer">
                        {set $date = $.get.date | split: ','}
                        <ul class="datepicker-popup__range">
                            <li>
                                <input type="text" class="input center input--small js-datepicker-min" value="{$date[0]}" readonly>
                            </li>
                            <li>

                            </li>
                            <li>
                                <input type="text" class="input center input--small js-datepicker-max" value="{$date[1]}" readonly>
                            </li>
                        </ul>

                        <button type="button" class="btn btn--small" data-apply-period>Применить</button>
                    </div>
                </div>

            </form>

            <!--filter balloons-->
            <div class="filter-balloons" data-ff-selected>
                <template data-ff-tpl>
                    <button class="filter-balloon" data-ff-item="$key-$value">$caption</button>
                </template>
                <button class="filter-balloon filter-balloon--reset" type="reset" form="filterDesignForm" data-ff-reset>Сбросить всё</button>
            </div>

            <table class="statistic-table">
                <tbody data-ff-results>
                {$resources}
                <tr data-mpc-remove="1" data-mpc-chunk="fffiltering/orders/item.tpl">
                    <td>
                        <div class="statistic-table__wrap">
                            <ul class="statistic-table__images">
                                {set $previews = $preview | split: '|'}
                                {if $previews}
                                    {foreach $previews as $path}
                                        <li>
                                            <img src="https://311725.selcdn.ru/custom_factory/{$path}" alt="">
                                        </li>
                                    {/foreach}
                                {/if}
                            </ul>
                            <div class="statistic-table__content">
                                <div class="statistic-table__title">{$types[$root_id]}</div>
                                <ul class="statistic-table__params">
                                    <li>Создан {$createdon | date: 'd.m.Y H:i'}</li>
                                    <li>Артикул: {$article}</li>
                                    <li>Вознаграждение: {$price}₽</li>
                                </ul>
                            </div>
                        </div>
                    </td>
                    <td>
                        <ul class="statistic-table__info">
                            <li>Заказов: {$orders?:0}</li>
                            <li>Выкупов: {$sales?:0}</li>
                            <li>Возвратов: {$returns?:0}</li>
                        </ul>
                    </td>
                    <td>
                        <div class="statistic-table__total">
                            Сумма выплат:
                            <span class="red">{$pays?:0} ₽</span>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>

            <div data-mpc-chunk="fffiltering/designs/pagination.tpl" data-mpc-include="1" data-mpc-copy="moderate_designs.tpl" class="d-flex justify-content-between" style="gap:20px;flex-wrap:wrap;margin-top:60px;"></div>
        </div>
    </div>

    <div id="modal-search" aria-hidden="true" data-mpc-chunk="common/search_modal.tpl" data-mpc-include="1" data-mpc-copy="moderate_users.tpl" class="modal"></div>
</div>