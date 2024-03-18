<div>
            <!--filter-->
            <form id="filterForm" data-ff-form="filterDesignForm" class="filter">
                <input type="hidden" name="configId" value="{$configId}">
                <div class="filter-column filter-column-design">
                    <div class="filter-item">
                        <div class="filter-name">Дизайнов: <span id="total">{$totalResources?:0}</span>
</div>
                    </div>
                    {$filters}
                    
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

            {include "file:chunks/common/search_modal.tpl"}
        </div>