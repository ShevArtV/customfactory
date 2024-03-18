<!--##{"templatename":"Модерация дизайнов","pagetitle":"Страница Модерации дизайнов","icon":"icon-tint", "extends": "12"}##-->

<!-- /usr/local/php/php-7.4/bin/php /home/host1860015/art-sites.ru/htdocs/customfactory/core/components/migxpageconfigurator/console/mgr_tpl.php web moderate_designs.tpl -->

<div id="{$id}" data-mpc-section="moderate_designs" data-mpc-name="Модерация дизайнов">
    <div class="container-medium">
        <div class="page input-group" data-mpc-field="content">
            Проверьте изображения от дизайнеров на соответствие техническим требованиям и допустимому содержанию
        </div>
    </div>

    <div data-mpc-unwrap="1" data-mpc-snippet="!ffFiltering|designs">
        <p class="page input-group" data-mpc-chunk="fffiltering/designs/ffempty.tpl">Дизайнов удовлетворяющих заданным параметрам не найдено.</p>
        <div data-mpc-chunk="fffiltering/designs/ffouter.tpl">
            <!--filter-->
            <form id="filterForm" data-ff-form="filterDesignForm" class="filter">
                <input type="hidden" name="configId" value="{$configId}">
                <div class="filter-column filter-column-design">
                    <div class="filter-item">
                        <div class="filter-name">Дизайнов: <span id="total">{$totalResources?:0}</span></div>
                    </div>
                    {$filters}
                    <div class="filter-item" data-mpc-remove="1" data-mpc-chunk="fffiltering/designs/fffcheckboxgroupouter.tpl">
                        <ul class="filter-list">
                            <li>
                                <div class="filter-name filter-name--select" data-popup-link="filter-{$key}">
                                    {('ff_frontend_'~$key) | lexicon}
                                </div>
                                <div class="popup-menu popup-menu--checked" data-popup="filter-{$key}">
                                    <ul class="filter-value-list scrollbar">
                                        {$options}
                                        <li data-mpc-remove="1" data-mpc-chunk="fffiltering/designs/ffcheckboxgroup.tpl">
                                            <label class="checkbox-label">
                                                {set $values = ($.get[$key] | split: ',') ?: []}
                                                {switch $key}
                                                {case 'parent'}
                                                {set $caption = $value | resource: 'pagetitle'}
                                                {default}
                                                {set $caption = $value}
                                                {/switch}
                                                <input class="checkbox" type="checkbox"
                                                       data-ff-filter="{$key}" name="{$key}[]"
                                                       data-ff-caption="{$caption}"
                                                       value="{$value}"
                                                       id="{$key}-{$idx}"
                                                       data-mpc-attr="{($value in list $values) ? 'checked' : ''}">
                                                <span class="checkbox-text checkbox-text--small">{$caption}</span>
                                            </label>
                                        </li>
                                    </ul>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="filter-item">
                        <div class="filter-name filter-name--select" data-popup-link="datepicker">
                            {if $.get.createdon == ('' | period: 'week')}
                                7 дней
                            {elseif $.get.createdon == ('' | period: 'month')}
                                Месяц
                            {elseif $.get.createdon == ('' | period: 'year')}
                                Год
                            {elseif $.get.createdon != ''}
                                {$.get.createdon | replace: ',' : '-'}
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
                                <li data-period-value="{'' | period: 'week'}" class="active">7 дней</li>
                                <li data-period-value="{'' | period: 'month'}">Месяц</li>
                                <li data-period-value="{'' | period: 'year'}">Год</li>
                            </ul>
                        </div>
                        <div class="datepicker-popup__content">
                            <input type="text" class="v_hidden" name="createdon" data-ff-filter="createdon" value="{$.get.createdon}" data-datepicker>
                        </div>
                    </div>
                    <div class="datepicker-popup__footer">
                        {set $createdon = $.get.createdon | split: ','}
                        <ul class="datepicker-popup__range">
                            <li>
                                <input type="text" class="input center input--small js-datepicker-min" value="{$createdon[0]}" readonly>
                            </li>
                            <li>

                            </li>
                            <li>
                                <input type="text" class="input center input--small js-datepicker-max" value="{$createdon[1]}" readonly>
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

            <!--filter-->
            <div class="filter filter--glass">
                <div class="filter-column">
                    <ul class="filter-list">
                        <li>
                            <div class="btn-group">
                                <div class="filter-item">
                                    <label class="checkbox-label">
                                        <input type="checkbox" class="checkbox">
                                        <span class="checkbox-text">Выбрать все</span>
                                    </label>
                                </div>
                                <div class="filter-item">
                                    <button class="btn btn--line btn--small">Очистить выбор</button>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="btn-group">
                                <div class="filter-item">
                                    <button class="btn btn--select btn--small" data-popup-link="popup-status">Новый</button>
                                    <div class="popup-menu popup-menu--checked" data-popup="popup-status">
                                        <ul>
                                            <li>
                                                <label class="checkbox-label">
                                                    <input type="checkbox" class="checkbox">
                                                    <span class="checkbox-text checkbox-text--small">В продаже</span>
                                                </label>
                                            </li>
                                            <li>
                                                <label class="checkbox-label">
                                                    <input type="checkbox" class="checkbox">
                                                    <span class="checkbox-text checkbox-text--small">На проверке тех.требований</span>
                                                </label>
                                            </li>
                                            <li>
                                                <label class="checkbox-label">
                                                    <input type="checkbox" class="checkbox">
                                                    <span class="checkbox-text checkbox-text--small">Отклонён</span>
                                                </label>
                                            </li>
                                            <li>
                                                <label class="checkbox-label">
                                                    <input type="checkbox" class="checkbox">
                                                    <span class="checkbox-text checkbox-text--small">Присвоение артикулов</span>
                                                </label>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="filter-item">
                                    <button class="btn btn--dark btn--small">Установить статус</button>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="filter-column">
                    <div class="btn-group">
                        <button class="btn btn--small">Удалить</button>
                        <button class="btn btn--glass btn--small">Скачать в Excel</button>
                    </div>
                </div>
            </div>

            <div class="columns" data-ff-results>
                {$resources}
                <div class="column col-4 md-col-6 sm-col-12" id="product-{$id}" data-mpc-remove="1" data-mpc-chunk="fffiltering/designs/item.tpl">
                    <div class="card-design">
                        <div class="card-design__check">
                            <label class="checkbox-label">
                                <input type="checkbox" class="checkbox">
                                <span class="checkbox-text"></span>
                            </label>
                        </div>

                        <ul class="card-design__images">
                            <li style="background-image: url(img/2023-12-23_123120.jpg)"></li>
                            <li style="background-image: url(img/2023-12-23_123120.jpg)"></li>
                            <li style="background-image: url(img/2023-12-23_123120.jpg)"></li>
                        </ul>
                        <div class="card-design__content">
                            <div class="card-design__title">{$pagetitle}</div>
                            <ul class="card-design__params">
                                <li>Номер ЛК: {$createdby | user: 'profile_num'} ({$createdby})</li>
                            </ul>
                        </div>
                        <div class="card-design__footer">
                            <ul class="card-design__params">
                                <li class="active">Статус: {$status}</li>
                                <li>Категория: <a href="">{$parent | resource: 'pagetitle'}</a></li>
                                <li>Тэг: <a href="">{$tags[0]}</a></li>
                                <li>Цвета:
                                    {foreach $color as $c last=$l}
                                        <a href="">{$c}</a>{if !$l},{/if}
                                    {/foreach}
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <div class="d-flex justify-content-between">
                <div data-pn-pagination class="pagination {$totalPages < 2 ? 'd-none' : ''}">
                    <button type="button" class="toggler start" data-pn-first="1"></button>
                    <button type="button" class="toggler prev" data-pn-prev></button>
                    <input type="number" name="page" data-pn-current form="filterForm" min="1" max="{$totalPages}" value="{$.get.page?:1}">

                    <span data-pn-total>{$totalPages}</span>
                    <button type="button" class="toggler next" data-pn-next></button>
                    <button type="button" class="toggler end" data-pn-last="{$totalPages}"></button>
                </div>
                <label>
                    <span>Показывать по:</span>
                    <input type="number" name="limit" data-pn-limit form="filterForm" class="red-input" min="1" value="{$limit}">
                </label>
            </div>

            <div id="modal-search" aria-hidden="true" data-mpc-chunk="common/search_modal.tpl" data-mpc-include="1" data-mpc-copy="moderate_users.tpl" class="modal"></div>
        </div>
    </div>
</div>