<!--##{"templatename":"Модерация дизайнов","pagetitle":"Страница Модерации дизайнов","icon":"icon-tint", "extends": "12"}##-->

<!-- /usr/local/php/php-7.4/bin/php /home/host1860015/art-sites.ru/htdocs/customfactory/core/components/migxpageconfigurator/console/mgr_tpl.php web moderate_designs.tpl -->
<!-- php7.4 www/core/components/migxpageconfigurator/console/mgr_tpl.php web moderate_designs.tpl -->

<div id="{$id}" data-mpc-section="moderate_designs" data-mpc-name="Модерация дизайнов">
    <div class="container-medium">
        <div class="page input-group" data-mpc-field="content">
            Проверьте изображения от дизайнеров на соответствие техническим требованиям и допустимому содержанию
        </div>
    </div>
    ##set $parents = $_modx->runSnippet('@FILE snippets/product/snippet.getparents.php', ['showUnpublished' => 1])}
    ##set $types = $_modx->runSnippet('@FILE snippets/product/snippet.gettypes.php', ['showUnpublished' => 1])}
    <div data-mpc-unwrap="1" data-mpc-snippet="!ffFiltering|designs">
        <p class="page input-group" data-mpc-chunk="fffiltering/designs/ffempty.tpl">Дизайнов удовлетворяющих заданным параметрам не найдено.</p>
        <div data-mpc-chunk="fffiltering/designs/ffouter.tpl">
            <!--filter-->
            <form id="filterForm" data-ff-form="filterDesignForm" class="filter">
                <input type="hidden" name="configId" value="{$configId}">
                <input type="hidden" name="configId" form="generateReport" value="{$configId}">
                <div class="filter-column">
                    <div class="filter-item">
                        <div class="filter-name">Дизайнов: <span id="total">{$totalResources?:0}</span></div>
                    </div>
                    <div class="filter-item">
                        <ul class="filter-list">
                            {$filters}
                            <li data-mpc-remove="1" data-mpc-chunk="fffiltering/designs/fffcheckboxgroupouter.tpl">
                                <div class="filter-name filter-name--select" data-popup-link="filter-{$key}">
                                    {('ff_frontend_'~$key) | lexicon}
                                </div>
                                <div class="popup-menu popup-menu--checked" data-popup="filter-{$key}">
                                    <ul class="filter-value-list scrollbar">
                                        {$options}

                                        <li data-mpc-remove="1" data-mpc-chunk="fffiltering/designs/ffcheckboxgroup.tpl">
                                            {set $statuses = ('statuses' | placeholder)}
                                            {*{if $key == 'status' && $value == 7 && $_modx->resource.template == 19}
                                                {set $flag = true}
                                            {/if}*}
                                            {if !$flag}
                                                <label class="checkbox-label">
                                                    {set $values = ($.get[$key] | split: ',') ?: []}
                                                    {switch $key}
                                                    {case 'parent'}
                                                    {set $caption = $categories[$value]}
                                                    {case 'root_id'}
                                                    {set $caption = $types[$value]}
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
                                            {/if}
                                        </li>
                                    </ul>
                                </div>
                            </li>
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
                                    <textarea class="input textarea" name="content" placeholder="Если дизайн не прошёл модерацию, обязательно укажите причину"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            {/if}

            <div class="columns" data-ff-results>
                {$resources}
                <div class="column col-4 md-col-6 sm-col-12" id="product-{$id}" data-mpc-remove="1" data-mpc-chunk="fffiltering/designs/item.tpl">
                    {if $status == 1 || ($prev_status == 1 && $status == 7)}
                        {set $class = 'product--new'}
                    {elseif $status == 2 || ($prev_status == 2 && $status == 7)}
                        {set $class = 'product--check'}
                    {elseif $status == 3}
                        {set $class = 'product--article'}
                    {elseif $status == 4}
                        {set $class = 'product--sale'}
                    {elseif $status == 5 || $status == 6}
                        {set $class = 'product--cancel'}
                    {/if}
                    <div class="card-design {$class}">
                        <div class="card-design__check">
                            <label class="checkbox-label">
                                <input type="checkbox" class="checkbox" name="selected_id[]" id="sel-product-{$id}" value="{$id}" form="listActionProducts">
                                <span class="checkbox-text"></span>
                            </label>
                        </div>


                        <ul class="card-design__images" data-mpc-attr="{if $status == 5} data-modal-show='reject-{$id}' {/if} {if ($status in list [1,2])}data-load-workflow='{$id}'{/if}">
                            {set $previews = $preview | split: '|'}
                            {if $previews}
                                {foreach $previews as $path}
                                    <li style="background-image: url({$_modx->config.file_prefix}{$path})"></li>
                                {/foreach}
                            {/if}
                        </ul>

                        <div class="card-design__content">
                            <div class="card-design__title" data-mpc-attr="{if ($status in list [1,2])}data-load-workflow='{$id}'{/if}">{$designer}</div>
                            <ul class="card-design__params">
                                <li>Номер ЛК: {$profilenum?:'Не задан'}</li>
                                <li>Создан {$createdon | date: 'd.m.Y H:i'}</li>
                            </ul>
                        </div>
                        <div class="card-design__footer">
                            <ul class="card-design__params">
                                <li class="active">Статус: {$statuses['product'][$status]['caption']}</li>
                                <li>Категория: <a href="#" data-modal-show="#modal-parent-{$id}"
                                                  data-for="#sel-product-{$id}">{$parent ? $categories[$parent] : 'Не задана'}</a>
                                </li>
                                <li>Тип товара: <a href="#" data-modal-show="#modal-root-{$id}"
                                                   data-for="#sel-product-{$id}">{$root_id ? $types[$root_id] : 'Не задан'}</a>
                                </li>
                                <li>Тэг: <a href="#" data-modal-show="#modal-tag-{$id}" data-for="#sel-product-{$id}">{$tags[0]?:'Назначить тэг'}</a>
                                </li>
                                <li>Цвета:
                                    {foreach $color as $c last=$l}
                                        <a href="#" data-modal-show="#modal-color-{$id}" data-for="#sel-product-{$id}">{$c}</a>{if !$l},{/if}
                                    {/foreach}
                                </li>
                            </ul>
                            <div style="padding-top:20px" class="product-articles">
                                <div class="product-articles__title">Артикулы</div>
                                <ul class="product-articles__grid">
                                    <li>
                                        <div class="product-articles__name">Внутренний</div>
                                        <div class="product-articles__value">
                                            <span>{$article?:'не присвоен'}</span>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="product-articles__name">Ozon</div>
                                        <div class="product-articles__value">
                                            <span>{$article_oz?:'не присвоен'}</span>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="product-articles__name">WB</div>
                                        <div class="product-articles__value">
                                            <span>{$article_wb?:'не присвоен'}</span>
                                        </div>
                                    </li>
                                    <li>
                                        <div class="product-articles__name">Я.Маркет</div>
                                        <div class="product-articles__value">
                                            <span>{$article_ya?:'не присвоен'}</span>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <div class="good-list">
                                {set $imgPrefix = $_modx->config.file_prefix}
                                <ul class="good-list__files">
                                    {foreach ($print | split: '|') as $img index=$i}
                                        <li><a href="{$imgPrefix}{$img}" download target="_blank">Печатный файл №{$i%2B1}</a></li>
                                    {/foreach}
                                </ul>
                            </div>
                        </div>

                        <div id="modal-parent-{$id}" aria-hidden="true" class="modal">
                            <div class="modal-main">
                                <div class="modal-close" data-modal-close></div>
                                <div class="modal-title">Выберите категорию</div>
                                <div class="modal-content scrollbar">
                                    {if $categories}
                                        <div class="columns-list">
                                            {foreach $categories as $rid => $title}
                                                <div class="columns-list__name">
                                                    <label class="checkbox-label">
                                                        <input type="radio" value="{$rid}" class="checkbox" name="data[{$id}][parent]"
                                                               data-mpc-attr="{$rid === $parent ? 'checked' : ''}"
                                                               form="listActionProducts">
                                                        <span class="checkbox-text">{$title}</span>
                                                    </label>
                                                </div>
                                            {/foreach}
                                        </div>
                                    {/if}
                                </div>
                                <div class="modal-footer center">
                                    <button type="button" class="btn" form="listActionProducts" data-si-event="click" data-si-preset="changeParent">Сохранить</button>
                                </div>
                            </div>
                        </div>

                        <div id="modal-root-{$id}" aria-hidden="true" class="modal">
                            <div class="modal-main">
                                <div class="modal-close" data-modal-close></div>
                                <div class="modal-title">Выберите тип товара</div>
                                <div class="modal-content scrollbar">
                                    {if $types}
                                        <div class="columns-list">
                                            {foreach $types as $rid => $title}
                                                <div class="columns-list__name">
                                                    <label class="checkbox-label">
                                                        <input type="radio" value="{$rid }" class="checkbox" name="data[{$id}][root_id]"
                                                               data-mpc-attr="{$rid  === $root_id ? 'checked' : ''}"
                                                               form="listActionProducts">
                                                        <span class="checkbox-text">{$title}</span>
                                                    </label>
                                                </div>
                                            {/foreach}
                                        </div>
                                    {/if}
                                </div>
                                <div class="modal-footer center">
                                    <button type="button" class="btn" form="listActionProducts" data-si-event="click" data-si-preset="changeRootId">Сохранить</button>
                                </div>
                            </div>
                        </div>

                        <div id="modal-tag-{$id}" aria-hidden="true" class="modal">
                            <input type="hidden" value="{$tag_label}" form="listActionProducts" name="data[{$id}][tags][]">
                            <div class="modal-main">
                                <div class="modal-close" data-modal-close></div>
                                <div class="modal-title">Назначьте тэг для дизайна</div>
                                <div class="search">
                                    <input type="text" class="input search-input" name="query" data-si-preset="search_tag" data-si-event="input" placeholder="введите тэг">
                                </div>
                                <div class="modal-content scrollbar">
                                    <div class="columns-list" data-checkbox-wrap>
                                        {foreach $allTags as $char => $items}
                                            <div class="columns-list__item">
                                                <div class="columns-list__letter">{$char | replace: 'A_' : ''}</div>
                                                {foreach $items as $tag_id => $tag_name}
                                                    <div class="columns-list__name">
                                                        <label class="checkbox-label">
                                                            <input type="radio"
                                                                   name="data[{$id}][tag_label]"
                                                                   data-tag="data[{$id}][tags][]"
                                                                   data-checkbox="{$tag_name}" value="{$tag_id}"
                                                                   data-mpc-attr="{$tags[0] == $tag_name ? 'checked' : '' }"
                                                                   form="listActionProducts" class="checkbox">
                                                            <span class="checkbox-text">{$tag_name}</span>
                                                        </label>
                                                    </div>
                                                {/foreach}
                                            </div>
                                        {/foreach}
                                    </div>
                                </div>
                                <div class="modal-footer center">
                                    <button type="button" class="btn" form="listActionProducts" data-si-event="click" data-si-preset="changeTags">Сохранить</button>
                                </div>
                            </div>
                        </div>

                        <div id="modal-color-{$id}" aria-hidden="true" class="modal">
                            <div class="modal-main">
                                <div class="modal-close" data-modal-close></div>
                                <div class="modal-title">Выберите цвета</div>
                                <div class="modal-content scrollbar">
                                    {if $colors}
                                        <div class="columns-list">
                                            {foreach $colors as $c}
                                                <div class="columns-list__name">
                                                    <label class="checkbox-label">
                                                        <input type="checkbox" value="{$c | strip}" class="checkbox" name="data[{$id}][color][]" data-color
                                                               data-mpc-attr="{(($c | strip) in list $color) ? 'checked' : ''}"
                                                               form="listActionProducts" data-checkbox="{$c | strip}">
                                                        <span class="checkbox-text">{$c | strip}</span>
                                                    </label>
                                                </div>
                                            {/foreach}
                                        </div>
                                    {/if}
                                </div>
                                <div class="modal-footer center">
                                    <button type="button" class="btn" form="listActionProducts" data-si-event="click" data-si-preset="changeColor">Сохранить</button>
                                </div>
                            </div>
                        </div>

                        {if $status == 5}
                            <div id="reject-{$id}" aria-hidden="false" class="modal">
                                <div class="modal-main" style="">
                                    <div class="modal-close" data-modal-close=""></div>
                                    <div class="modal-area modal-content scrollbar">
                                        <div class="good-items">
                                            <div class="good-item">
                                                <div class="columns">
                                                    <div class="column col-6 md-col-12">
                                                        <ul class="good-item__params">
                                                            <li>Товар: {$types[$root_id]}</li>
                                                            <li style="display:flex;gap:5px;align-items:center;">
                                                                <span class="good-item__status status--cancel"></span>
                                                                Отклонён
                                                            </li>
                                                            <li>Тэг: {$tags[0]?:'не задан'}</li>
                                                            <li>Цвета: {$color ? ($color | join: '; ') : 'не заданы'}</li>
                                                        </ul>
                                                    </div>
                                                    <div class="column col-6 md-col-12">
                                                        <div class="good-reports">
                                                            <div class="good-report">
                                                                <div class="good-report__date">{$editedon}</div>
                                                                <div class="good-report__quote">
                                                                    {$content}
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {/if}

                    </div>
                </div>
            </div>

            <div data-mpc-chunk="fffiltering/designs/pagination.tpl" data-mpc-include="1" class="d-flex justify-content-between" style="gap:20px;flex-wrap:wrap;margin-top:60px;">
                <div data-pn-pagination class="pagination {$totalPages < 2 ? 'd-none' : ''}">
                    <button type="button" class="toggler start" data-pn-first="1"></button>
                    <button type="button" class="toggler prev" data-pn-prev></button>
                    <input type="number" name="page" data-pn-current form="filterForm" data-si-preset="flatfilters" min="1" max="{$totalPages}" value="{$.get.page?:1}">

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
    </div>

    <div id="workflow" aria-hidden="false" class="modal">
        <div class="modal-main" data-mpc-chunk="common/workflow_moderator.tpl">
            {set $imgPrefix = $_modx->config.file_prefix}
            <div class="modal-close" data-modal-close=""></div>
            <form data-si-form="modalProductStatus" data-si-nosave enctype="multipart/form-data" class="modal-area modal-content scrollbar">
                <input type="hidden" name="selected_id[]" value="{$id}">
                <div class="good-items">
                    {foreach $workflow as $item last=$l}
                        {if $l}
                            <div class="good-item">
                                <div class="columns">
                                    <div class="column col-6 md-col-12">
                                        <div class="good-images">
                                            {foreach ($item.preview | split: '|') as $img index=$i}
                                                <div class="good-image">
                                                    <div class="good-image__img">
                                                        <img src="{$imgPrefix}{$img}" alt="">
                                                    </div>
                                                    <div class="good-image__title">{$img}</div>
                                                </div>
                                            {/foreach}
                                        </div>
                                        <div data-fu-wrap data-si-preset="upload_screens" data-si-nosave>
                                            <input type="hidden" name="filelist" form="toRework" data-fu-list>
                                            <div data-fu-progress=""></div>
                                            <template data-fu-tpl>
                                                <div class="good-image" data-fu-path="$path">
                                                    <div class="good-image__close"></div>
                                                    <div class="good-image__img">
                                                        <img src="$path" alt="">
                                                    </div>
                                                    <div class="good-image__title">$filename</div>
                                                </div>
                                            </template>
                                            <div class="good-images" style="width:100%;flex-wrap:wrap;" data-fu-dropzone>
                                                <div class="good-image">
                                                    <div class="good-image__add">
                                                        <span>Загрузите скриншоты</span>
                                                        <input data-fu-field multiple type="file" form="toRework" class="good-image__file">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="good-list">
                                            <div class="good-item__title">Проверить файлы</div>
                                            <ul class="good-list__files">
                                                {foreach ($item.print | split: '|') as $img index=$i}
                                                    <li><a href="{$imgPrefix}{$img}" download target="_blank">Печатный файл №{$i%2B1}</a></li>
                                                {/foreach}
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="column col-6 md-col-12">
                                        <div class="good-reports">
                                            {if $item.designer_comment}
                                                <div class="good-report">
                                                    <div class="good-report__date">{$item.designer_date}</div>
                                                    <div class="good-report__quote">
                                                        {$item.designer_comment}
                                                    </div>
                                                </div>
                                            {/if}

                                            <textarea class="input textarea" name="content" data-sync="#content" placeholder="Введите комментарий"></textarea>

                                            <div class="good-report">
                                                <div class="good-item__title">
                                                    Установить статус:
                                                </div>
                                                <div class="btn-group">
                                                    <div class="js-custom-select select-pill">
                                                        <select class="" name="status">
                                                            {foreach $statuses['product'] as $sid => $data}
                                                                {if ($sid in list $statuses['product'][$status]['allow']) && $sid !== 7}
                                                                    <option value="{$sid}">{$data.caption}</option>
                                                                {/if}
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                    <button type="button" class="btn btn--small" data-si-event="click" data-si-preset="changeStatus">Отправить</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {else}
                            <div class="good-item">
                                <div class="columns">
                                    <div class="column col-6 md-col-12">
                                        <div class="good-images">
                                            {foreach ($item.preview | split: '|') as $img index=$i}
                                                <div class="good-image">
                                                    <div class="good-image__img">
                                                        <img src="{$imgPrefix}{$img}" alt="">
                                                    </div>
                                                    <div class="good-image__title">{$img}</div>
                                                </div>
                                            {/foreach}
                                        </div>
                                    </div>
                                    <div class="column col-6 md-col-12">
                                        <div class="good-reports">
                                            {if $item.designer_comment}
                                                <div class="good-report">
                                                    <div class="good-report__date">{$item.designer_date}</div>
                                                    <div class="good-report__quote">
                                                        {$item.designer_comment}
                                                    </div>
                                                </div>
                                            {/if}
                                            {if $item.moderator_comment}
                                                <div class="good-report good-report__right">
                                                    <div class="good-report__date">{$item.moderator_date}</div>
                                                    <div class="good-report__quote">
                                                        {$item.moderator_comment}
                                                    </div>
                                                </div>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {/if}
                    {/foreach}
                </div>
            </form>
            {if $status in list [1,2]}
                <form id="toRework" data-si-form class="modal-footer center">
                    <input type="hidden" name="selected_id[]" value="{$id}">
                    <input type="hidden" name="status" value="7">
                    <input type="hidden" name="content" id="content" value="">
                    <button type="button" class="btn btn--small btn--line" data-si-preset="toRework" data-si-event="click">На доработку</button>
                </form>
            {/if}
        </div>
    </div>

</div>
