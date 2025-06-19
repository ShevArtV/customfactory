<div>
            <div class="container-small">
                <!--statistic-showcase-->
                <div class="statistic-showcase">
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">
                            {set $dates = $.get.date | split: ','}
                            Всего за период <br>
                            с <span data-total="total_min">{$dates[0]}</span> по <span data-total="total_max">{$dates[1]}</span>
                        </div>
                    </div>
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Заказов:</div>
                        <div class="statistic-showcase__value">
<span data-total="total_orders">0</span> шт.</div>
                    </div>
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Продаж:</div>
                        <div class="statistic-showcase__value">
<span data-total="total_sales">0</span> шт.</div>
                    </div>
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Возвратов:</div>
                        <div class="statistic-showcase__value">
<span data-total="total_returns">0</span> шт.</div>
                    </div>
                    <div class="statistic-showcase__item active">
                        <div class="statistic-showcase__title">Выплат:</div>
                        <div class="statistic-showcase__value">
<span data-total="total_pays">0</span> ₽</div>
                    </div>
                </div>

            </div>

            <form id="filterForm" data-ff-form="filterDesignForm" class="filter">
                <input type="hidden" name="configId" value="{$configId}">

                <div class="filter-column">
                    <div class="filter-item">
                        <div class="filter-name">Дизайнов: <span id="total">{$totalResources?:0}</span>
</div>
                    </div>
                    <div class="filter-item">
                        <ul class="filter-list">
                            {$filters}
                            <li>
                                <div class="js-custom-select">
                                    <select data-ff-filter="sortby" name="sortby">
                                        <option value="product_id|DESC" {$.get['sortby'] === 'product_id|DESC' ? 'selected' : ''}>По новизне</option>
                                        <option value="orders|DESC" {$.get['sortby'] === 'orders|DESC' ? 'selected' : ''}>Больше заказов</option>
                                        <option value="orders|ASC" {$.get['sortby'] === 'orders|ASC' ? 'selected' : ''}>Меньше заказов</option>
                                        <option value="sales|DESC" {$.get['sortby'] === 'sales|DESC' ? 'selected' : ''}>Больше выкупов</option>
                                        <option value="sales|ASC" {$.get['sortby'] === 'sales|ASC' ? 'selected' : ''}>Меньше выкупов</option>
                                        <option value="pays|DESC" {$.get['sortby'] === 'pays|DESC' ? 'selected' : ''}>Больше выплат</option>
                                        <option value="pays|ASC" {$.get['sortby'] === 'pays|ASC' ? 'selected' : ''}>Меньше выплат</option>
                                    </select>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="filter-column">
                    <div class="filter-item">
                        <div class="filter-name filter-name--select" data-popup-link="datepicker">
                            {if $.get.date == ('' | period: 'week')}
                                Последние 7 дней
                            {elseif $.get.date == ('' | period: 'month')}
                                Текущий месяц
                            {elseif $.get.date == ('' | period: 'prev_month')}
                                Предыдущий месяц
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
                                <li data-period-value="{'' | period: 'week'}" class="active">Последние 7 дней</li>
                                <li data-period-value="{'' | period: 'month'}">Текущий месяц</li>
                                <li data-period-value="{'' | period: 'prev_month'}">Предыдущий месяц</li>
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
                
                </tbody>
            </table>

            {include "file:chunks/fffiltering/designs/pagination.tpl"}
        </div>