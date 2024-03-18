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
                <input type="hidden" name="configId" form="generateReport" value="{$configId}">
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
                                            {set $statuses = ('statuses' | placeholder)}
                                            <label class="checkbox-label">
                                                {set $values = ($.get[$key] | split: ',') ?: []}
                                                {switch $key}
                                                {case 'parent'}
                                                {set $caption = $value | resource: 'pagetitle'}
                                                {case 'status'}
                                                {set $caption = $statuses['product'][$value]['caption']}
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
                                        <select class="" name="status">
                                            {foreach $statuses['product'] as $id => $data}
                                                <option value="{$id}">{$data.caption}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="filter-item">
                                    <button type="button" class="btn btn--dark btn--small" data-si-event="click" data-si-preset="setProductsStatus">Установить статус</button>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="filter-column">
                    <div class="btn-group">
                        <button class="btn btn--small" type="button" data-si-event="click" data-si-preset="removeProducts">Удалить</button>
                        <button class="btn btn--glass btn--small" type="button" data-modal-show="#modal-excel">Скачать в Excel</button>
                    </div>
                </div>
                <div id="modal-comment" aria-hidden="true" class="modal modal-main_sm">
                    <div class="modal-main">
                        <div class="modal-close" data-modal-close></div>
                        <div class="modal-content">
                            <div class="designer-card__content">
                                <h3>Причина отказа:</h3>
                                <textarea class="input textarea" name="content" placeholder="Если дизайн не прошёл модерацию, обязательно укажите причину"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </form>

            <div class="columns" data-ff-results>
                {$resources}
                <div class="column col-4 md-col-6 sm-col-12" id="product-{$id}" data-mpc-remove="1" data-mpc-chunk="fffiltering/designs/item.tpl">

                    <div class="card-design">
                        <div class="card-design__check">
                            <label class="checkbox-label">
                                <input type="checkbox" class="checkbox" name="selected_id[]" value="{$id}" form="listActionProducts">
                                <span class="checkbox-text"></span>
                            </label>
                        </div>

                        <ul class="card-design__images">
                            <li style="background-image: url(img/2023-12-23_123120.jpg)"></li>
                            <li style="background-image: url(img/2023-12-23_123120.jpg)"></li>
                            <li style="background-image: url(img/2023-12-23_123120.jpg)"></li>
                        </ul>
                        <div class="card-design__content">
                            <div class="card-design__title">{$pagetitle} <small>(id:{$id})</small></div>
                            <ul class="card-design__params">
                                <li>Номер ЛК: {$createdby | user: 'profile_num'} ({$createdby})</li>
                            </ul>
                        </div>
                        <div class="card-design__footer">
                            <ul class="card-design__params">
                                {set $statuses = ('statuses' | placeholder)}
                                <li class="active">Статус: {$statuses['product'][$status]['caption']}</li>
                                <li>Категория: <a href="">{$parent | resource: 'pagetitle'}</a></li>
                                <li>Тип товара: <a href="">{$roo_id | resource: 'pagetitle'}</a></li>
                                <li>Тэг: <a href="#" data-modal-show="#modal-tag-{$id}">{$tags[0]?:'Назначить тэг'}</a></li>
                                <li>Цвета:
                                    {foreach $color as $c last=$l}
                                        <a href="#" data-modal-show="#modal-color-{$id}">{$c}</a>{if !$l},{/if}
                                    {/foreach}
                                </li>
                            </ul>
                        </div>
                        <div id="modal-tag-{$id}" aria-hidden="true" class="modal">
                            <input type="hidden" value="{$tag_label}" form="listActionProducts" name="data[{$props.pid}][tags][]">
                            <div class="modal-main">
                                <div class="modal-close" data-modal-close></div>
                                <div class="modal-title">Назначьте тэг для дизайна</div>
                                <div class="search">
                                    <input type="text" class="input search-input" name="query" data-si-preset="search_tag" data-si-event="input" placeholder="введите тэг">
                                </div>
                                <div class="modal-content scrollbar">
                                    <div class="columns-list" data-checkbox-wrap data-mpc-snippet="getTagsByAlphabet|product" data-mpc-symbol="{ ">
                                        <div class="columns-list__item" data-mpc-remove="1" data-mpc-chunk="gettagsbyalphabet/char.tpl">
                                            <div class="columns-list__letter">{$char | replace: 'A_' : ''}</div>
                                            {$tags}
                                            <div class="columns-list__name" data-mpc-remove="1" data-mpc-chunk="gettagsbyalphabet/tag_product.tpl">
                                                <label class="checkbox-label">
                                                    <input type="radio"
                                                           name="data[{$props.pid}][tag_label]"
                                                           data-tag="data[{$props.pid}][tags][]"
                                                           data-checkbox="{$name}" value="{$label}"
                                                           data-mpc-attr="{$props.tag === $name ? 'checked' : '' }"
                                                           form="listActionProducts" class="checkbox">
                                                    <span class="checkbox-text">{$name}</span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="columns-list__letter" data-mpc-chunk="gettagsbyalphabet/empty.tpl">По запросу "{$query}" теги не найдены.</div>
                                    </div>
                                </div>
                                <div class="modal-footer center">
                                    <button type="button" class="btn" data-si-event="click" data-si-preset="changeTag">Сохранить</button>
                                </div>
                            </div>
                        </div>

                        <div id="modal-color-{$id}" aria-hidden="true" class="modal">
                            <div class="modal-main">
                                <div class="modal-close" data-modal-close></div>
                                <div class="modal-content scrollbar">
                                    {set $colors = 51982 | resource: 'colors'}
                                    {if $colors}
                                        <div class="columns-list">
                                            {set $colors = $colors | split: ','}
                                            {foreach $colors as $c index=$id}
                                                <div class="columns-list__name">
                                                    <label class="checkbox-label">
                                                        <input type="checkbox" value="{$c | strip}" class="checkbox" name="data[{$id}][color][]" data-color
                                                               data-mpc-attr="{(($c | strip) in list $color) ? 'checked' : ''}"
                                                               form="uploadQuizForm" data-checkbox="{$c | strip}">
                                                        <span class="checkbox-text">{$c | strip}</span>
                                                    </label>
                                                </div>
                                            {/foreach}
                                        </div>
                                    {/if}
                                </div>
                                <div class="modal-footer center">
                                    <button type="button" class="btn" data-checkbox-btn="4">Выбрать</button>
                                </div>
                            </div>
                        </div>

                        <div id="modal-parent-{$id}" aria-hidden="true" class="modal">
                            <div class="modal-main">
                                <div class="modal-close" data-modal-close></div>
                                <div class="modal-content scrollbar">
                                    {set $colors = 51982 | resource: 'colors'}
                                    {if $colors}
                                        <div class="columns-list">
                                            {set $colors = $colors | split: ','}
                                            {foreach $colors as $c index=$id}
                                                <div class="columns-list__name">
                                                    <label class="checkbox-label">
                                                        <input type="checkbox" value="{$c | strip}" class="checkbox" name="data[{$id}][color][]" data-color
                                                               data-mpc-attr="{(($c | strip) in list $color) ? 'checked' : ''}"
                                                               form="uploadQuizForm" data-checkbox="{$c | strip}">
                                                        <span class="checkbox-text">{$c | strip}</span>
                                                    </label>
                                                </div>
                                            {/foreach}
                                        </div>
                                    {/if}
                                </div>
                                <div class="modal-footer center">
                                    <button type="button" class="btn" data-checkbox-btn="4">Выбрать</button>
                                </div>
                            </div>
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
        </div>
    </div>
</div>