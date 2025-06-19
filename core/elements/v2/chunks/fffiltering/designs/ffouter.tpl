<div>
            <!--filter-->
            <form id="filterForm" data-ff-form="filterDesignForm" class="filter">
                <input type="hidden" name="configId" value="{$configId}">
                <input type="hidden" name="configId" form="generateReport" value="{$configId}">
                <div class="filter-column">
                    <div class="filter-item">
                        <div class="filter-name">Дизайнов: <span id="total">{$totalResources?:0}</span>
</div>
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
                                <li data-period-value="{'' | period: 'week'}" class="active">Последние 7 дней</li>
                                <li data-period-value="{'' | period: 'month'}">Текущий месяц</li>
                                <li data-period-value="{'' | period: 'prev_month'}">Предыдущий месяц</li>
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

            {if $_modx->resource.template === 19}
                <!--filter-->
                <form data-si-form="listActionProducts" id="listActionProducts" data-si-nosave class="filter filter--glass">
                    <div class="filter-column">
                        <ul class="filter-list">
                            <li>
                                <div class="btn-group">
                                    <div class="filter-item">
                                        <label class="checkbox-label">
                                            <input type="checkbox" class="checkbox" data-select-all>
                                            <span class="checkbox-text">Выбрать все</span>
                                        </label>
                                    </div>
                                    <div class="filter-item">
                                        <button type="button" class="btn btn--line btn--small" data-unselect-all>Очистить выбор</button>
                                    </div>
                                </div>
                            </li>
                            <li>
                                <div class="btn-group">
                                    <div class="filter-item">
                                        <div class="js-custom-select select-pill">
                                            {set $statuses = ('statuses' | placeholder)}
                                            <select class="" data-list-status="5" name="status">
                                                {foreach $statuses['product'] as $id => $data}
                                                    {if $id !== 7}
                                                        <option value="{$id}">{$data.caption}</option>
                                                    {/if}
                                                {/foreach}
                                            </select>
                                        </div>
                                    </div>
                                    <div class="filter-item">
                                        <button type="button" class="btn btn--dark btn--small" data-si-event="click" data-si-preset="changeStatus">Установить статус</button>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="filter-column">
                        <div class="btn-group">
                            <button class="btn btn--small" type="button" form="listActionProducts" data-si-event="click" data-si-preset="changeDeleted">Удалить</button>
                            <button class="btn btn--glass btn--small" type="button" data-modal-show="#modal-excel">Скачать в Excel</button>
                        </div>
                    </div>
                    <div id="modal-comment" aria-hidden="true" class="modal modal-main_sm">
                        <div class="modal-main">
                            <div class="modal-close" data-modal-close></div>
                            <div class="modal-content">
                                <div class="designer-card__content">
                                    <h3>Причина отказа:</h3>
                                    <textarea class="input textarea" name="content" placeholder="Если дизайн не прошёл модерацию, обязательно укажите причину" data-comment-input style="min-height: 120px; margin-bottom: 20px;"></textarea>
                                </div>
                                <div class="modal-footer center" style="margin-top: 15px;">
                                    <button type="button" class="btn btn--small btn--line" data-reject-product data-comment-submit>Отклонить</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            {/if}

            <div class="columns" data-ff-results>
                {$resources}
                
            </div>

            {include "file:chunks/fffiltering/designs/pagination.tpl"}

            {include "file:chunks/common/search_modal.tpl"}

            {if $_modx->resource.template === 19}
                <div id="modal-excel" aria-hidden="true" class="modal">
                    <form id="generateReport" data-si-form="generateReport" data-si-nosave class="modal-main">
                        <div class="modal-close" data-modal-close></div>
                        <div class="modal-content scrollbar">
                            <h2>Выберите данные для отображения в файле.</h2>
                            <div class="columns-list columns-list-2">
                                <input type="hidden" name="className" value="msProduct">
                                <input type="checkbox" name="captions[id][]" value="ID" checked class="v_hidden">
                                <input type="checkbox" name="names[]" value="id" checked class="v_hidden">
                                {set $groups = $_modx->runSnippet('@FILE snippets/product/snippet.getproductfields.php', [])}
                                {foreach $groups as $group => $fields}
                                    <div class="columns-list__item">
                                        <div class="columns-list__letter">{$group}</div>
                                        {foreach $fields as $key => $caption}
                                            <div class="columns-list__name">
                                                <input type="checkbox" name="captions[{$key}][]" data-caption="{$key}" value="{$caption}" class="v_hidden">
                                                <label class="checkbox-label">
                                                    <input type="checkbox" name="names[]" value="{$key}" data-key="{$key}" class="checkbox">
                                                    <span class="checkbox-text">{$caption}</span>
                                                </label>
                                            </div>
                                        {/foreach}
                                    </div>
                                {/foreach}
                            </div>
                        </div>
                        <div class="modal-footer center">
                            <button type="button" class="btn" data-si-event="click" data-si-preset="generate_report">Скачать</button>
                        </div>
                    </form>
                </div>
            {/if}
        </div>