<!--##{"templatename":"Модерация дизайнеров","pagetitle":"Страница Модерации дизайнеров","icon":"icon-tasks", "extends": "12"}##-->

<!-- /usr/local/php/php-7.4/bin/php /home/host1860015/art-sites.ru/htdocs/customfactory/core/components/migxpageconfigurator/console/mgr_tpl.php web moderate_users.tpl -->

<div id="{$id}" data-mpc-section="moderate_users" data-mpc-name="Модерация дизайнеров">
    <div data-mpc-unwrap="1" data-mpc-snippet="!ffFiltering|designers">
        <p class="page input-group" data-mpc-chunk="fffiltering/designers/ffempty.tpl">Дизайнеров удовлетворяющих заданным параметрам не найдено.</p>
        <div data-mpc-chunk="fffiltering/designers/ffouter.tpl">
            <form id="filterForm" class="filter" action="#" data-ff-form="filterForm">
                <input type="hidden" name="configId" value="{$configId}">
                <input type="hidden" name="configId" form="generateReport" value="{$configId}">
                <div class="filter-column">
                    <div class="filter-item">
                        <div class="filter-name">Дизайнеров: <span id="total">{$totalResources?:0}</span></div>
                    </div>
                    {$filters}
                    <div class="filter-item" data-mpc-remove="1" data-mpc-chunk="fffiltering/designers/ffselect.tpl">
                        <div class="d-flex align-items-center column-gap-10">
                            <label class="">Статус:</label>
                            <div class="js-custom-select">
                                <select class="" data-ff-filter="{$key}" name="{$key}">
                                    <option value="" data-mpc-attr="{!$.get[$key] ? 'selected' : ''}">Все</option>
                                    {$options}
                                    <div data-mpc-chunk="fffiltering/designers/ffoption.tpl" data-mpc-remove="1" data-mpc-unwrap="1">
                                        {set $statuses = ('statuses' | placeholder)}
                                        <option value="{$value}" data-mpc-attr="{($value == $.get[$key]) ? 'selected' : ''}">{$statuses.designer[$value].caption}</option>
                                    </div>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="filter-item" data-mpc-remove="1" data-mpc-chunk="fffiltering/designers/ffselectlegal.tpl">
                        <div class="d-flex align-items-center column-gap-10">
                            <label class="">Правовая форма:</label>
                            <div class="js-custom-select">
                                <select class="" data-ff-filter="{$key}" name="{$key}">
                                    <option value="" data-mpc-attr="{!$.get[$key] ? 'selected' : ''}">Любая</option>
                                    {$options}
                                    <div data-mpc-chunk="fffiltering/designers/ffoptionlegal.tpl" data-mpc-remove="1" data-mpc-unwrap="1">
                                        <option value="{$value}" data-mpc-attr="{($value == $.get[$key]) ? 'selected' : ''}">{$value}</option>
                                    </div>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="filter-item" data-mpc-remove="1" data-mpc-chunk="fffiltering/designers/ffselectoffer.tpl">
                        <div class="d-flex align-items-center column-gap-10">
                            <label class="">Оферта:</label>
                            <div class="js-custom-select">
                                <select class="" data-ff-filter="{$key}" name="{$key}">
                                    <option value="" data-mpc-attr="{!$.get[$key] ? 'selected' : ''}">Не важно</option>
                                    {$options}
                                    <div data-mpc-chunk="fffiltering/designers/ffoptionoffer.tpl" data-mpc-remove="1" data-mpc-unwrap="1">
                                        <option value="{$value}"
                                                data-mpc-attr="{($value == $.get[$key]) ? 'selected' : ''}">{$value === 'Да' ? 'Принята' : 'Не принята'}</option>
                                    </div>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="filter-item" data-mpc-remove="1" data-mpc-chunk="fffiltering/designers/ffcheckboxoffer.tpl">
                        <label class="checkbox-label">
                            <input type="checkbox" class="checkbox" data-ff-filter="{$key}" name="{$key}" value="1" id="{$key}" data-mpc-attr="{$.get[$key] ? 'checked' : ''}">
                            <span class="checkbox-text">Оферта принята</span>
                        </label>
                    </div>
                </div>
                <div class="filter-column">
                    <div class="filter-item">
                        <div class="filter-name" data-modal-show="#modal-excel">Скачать в Excel</div>
                    </div>
                    <div class="filter-item filter-item--search">
                        <button type="button" class="filter-search" data-modal-show="#modal-search"></button>
                    </div>
                </div>
            </form>

            <form data-si-form="listActionUsers" id="listActionUsers" data-si-nosave class="filter filter--glass">
                <div class="filter-column">
                    <ul class="filter-list">
                        <li>
                            <div class="btn-group">
                                <div class="filter-item">
                                    <label class="checkbox-label">
                                        <input type="checkbox" data-select-all class="checkbox">
                                        <span class="checkbox-text">Выбрать все</span>
                                    </label>
                                </div>
                                <div class="filter-item">
                                    <button class="btn btn--line btn--small" type="button" data-unselect-all>Очистить выбор</button>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="btn-group">
                                <div class="filter-item">
                                    <div class="js-custom-select select-pill">
                                        {set $statuses = ('statuses' | placeholder)}
                                        <select class="" data-list-status="3" name="status">
                                            {foreach $statuses['designer'] as $id => $data}
                                                <option value="{$id}">{$data.caption}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="filter-item">
                                    <button class="btn btn--dark btn--small" type="button" data-si-event="click" data-si-preset="setStatusUsers">Установить статус</button>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="filter-column">
                    <div class="btn-group">
                        <button class="btn btn--small" type="button" data-si-event="click" data-si-preset="unactiveUsers">Удалить выбранные</button>
                    </div>
                </div>
                <div id="modal-comment" aria-hidden="true" class="modal modal-main_sm">
                    <div class="modal-main">
                        <div class="modal-close" data-modal-close></div>
                        <div class="modal-content">
                            <div class="designer-card__content">
                                <h3>Причина отказа:</h3>
                                <textarea class="input textarea" name="comment" placeholder="Если дизайнер не прошёл модерацию, обязательно укажите причину"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </form>

            <div class="designer-items" data-ff-results>
                {$resources}
                <div class="designer-item" id="designer-{$id}" data-mpc-remove="1" data-mpc-chunk="fffiltering/designers/item.tpl">
                    <div class="columns">
                        <div class="column col-6 sm-col-12">
                            <div class="designer-card">
                                <div class="designer-card__content">
                                    <div class="profile-header profile-header--card">
                                        {set $photo = $photo ?: 'assets/project_files/img/cabinet/no-photo.jpg'}
                                        <div class="profile-header__avatar">
                                            <img src="{$photo}" alt="">
                                        </div>
                                        <div class="profile-header__name">{$fullname?:$username}</div>
                                    </div>

                                    <ul class="designer-card__info">
                                        <li>
                                            Дата
                                            регистрации: {$createdon ? '<span data-copy title="Нажмите для копирования">'~($createdon | date: 'd.m.Y H:i')~'</span>': '<span class="red">Не указано</span>'}
                                        </li>
                                        <li>
                                            Дата
                                            рождения: {$dob ? '<span data-copy title="Нажмите для копирования">'~($dob | date: 'd.m.Y')~'</span>': '<span class="red">Не указано</span>'}
                                        </li>
                                        <li>
                                            Телефон: {$phone ? '<span data-copy title="Нажмите для копирования">'~$phone~'</span>' : '<span class="red">Не указано</span>'}
                                        </li>
                                        <li>
                                            E-mail: {$email ?'<span data-copy title="Нажмите для копирования">'~$email~'</span>': '<span class="red">Не указано</span>'}
                                        </li>
                                        <li>
                                            Оферта: {$extended.offer === 'Да' ? '<span class="green">Принята</span>' : '<span class="red">Не принята</span>'}
                                        </li>
                                        <li>
                                            Дата принятия
                                            оферты: {$extended[('offerPageKey' | placeholder)] ? '<span data-copy title="Нажмите для копирования">'~$extended[('offerPageKey' | placeholder)]~'</span>' : '<span class="red">Не принята</span>'}
                                        </li>
                                        <li>
                                            Фактический
                                            адрес: {$address_fact ?'<span data-copy title="Нажмите для копирования">'~$zip_fact~', '~$address_fact~'</span>': '<span class="red">Не указано</span>'}
                                        </li>
                                        <li>
                                            Адрес для
                                            корреспонденции: {$address ?'<span data-copy title="Нажмите для копирования">'~$zip~', '~$address~'</span>': '<span class="red">Не указано</span>'}
                                        </li>
                                    </ul>
                                </div>
                                <div class="designer-card__content">
                                    <h3>Проверить паспортные данные:</h3>
                                    <ul class="designer-card__info">
                                        <li>
                                            Серия
                                            паспорта: {$pass_series ?'<span data-copy title="Нажмите для копирования">'~$pass_series~'</span>': '<span class="red">Не указано</span>'}
                                        </li>
                                        <li>
                                            Номер
                                            паспорта: {$pass_num ?'<span data-copy title="Нажмите для копирования">'~$pass_num~'</span>': '<span class="red">Не указано</span>'}
                                        </li>
                                        <li>
                                            Кем и когда
                                            выдан: {$extended[pass_where] ?'<span data-copy title="Нажмите для копирования">'~$extended[pass_date]~', '~$extended[pass_where]~'</span>': '<span class="red">Не указано</span>'}
                                        </li>
                                        <li>
                                            Код
                                            подразделения: {$extended.pass_code ?'<span data-copy title="Нажмите для копирования">'~$extended.pass_code~'</span>': '<span class="red">Не указано</span>'}
                                        </li>
                                        <li>
                                            Адрес
                                            регистрации: {$extended.pass_address ?'<span data-copy title="Нажмите для копирования">'~$extended.pass_address~'</span>': '<span class="red">Не указано</span>'}
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="column col-6 sm-col-12">
                            <div class="designer-card">
                                <div class="designer-card__content">
                                    <h3>Проверить документы {$legal_form === 'ИП' ? 'ИП' : 'самозанятого'}:</h3>
                                    <ul class="designer-card__info">
                                        <li>
                                            ИНН: {$inn ?'<span data-copy title="Нажмите для копирования">'~$inn~'</span>': '<span class="red">Не указано</span>'}
                                        </li>
                                        <li class="{$legal_form === 'ИП' ? 'd-none' : ''}">
                                            Номер справки
                                            самозанятого: {$extended.certificate_num ?'<span data-copy title="Нажмите для копирования">'~$extended.certificate_num~'</span>': '<span class="red">Не указано</span>'}
                                        </li>
                                        <li class="{$legal_form === 'ИП' ? 'd-none' : ''}">
                                            Дата выдачи
                                            справки: {$extended.certificate_date ?'<span data-copy title="Нажмите для копирования">'~$extended.certificate_date~'</span>': '<span class="red">Не указано</span>'}
                                        </li>
                                        <li class="{$legal_form === 'ИП' ? 'd-none' : ''}">
                                            СНИЛС: {$extended.insurance ?'<span data-copy title="Нажмите для копирования">'~$extended.insurance~'</span>': '<span class="red">Не указано</span>'}
                                        </li>
                                        <li class="{$legal_form === 'ИП' ? '' : 'd-none'}">
                                            Адрес регистрации
                                            ИП: {$extended.address_ip ?'<span data-copy title="Нажмите для копирования">'~$extended.address_ip~'</span>': '<span class="red">Не указано</span>'}
                                        </li>
                                        <li class="{$legal_form === 'ИП' ? '' : 'd-none'}">
                                            ОГРНИП: {$extended.ogrnip ?'<span data-copy title="Нажмите для копирования">'~$extended.ogrnip~'</span>': '<span class="red">Не указано</span>'}
                                        </li>
                                        <li class="{$legal_form === 'ИП' ? 'd-none' : ''}">
                                            {if $extended.selfemployed_img}
                                                <a href="{$extended.selfemployed_img}" target="_blank">
                                                    Справка о постановке на учет в качестве плательщика «Налога на профессиональный доход»
                                                </a>
                                            {else}
                                                <a>Справка о постановке на учет в качестве плательщика «Налога на профессиональный доход» не загружена</a>
                                            {/if}
                                        </li>
                                        <li class="{$legal_form === 'ИП' ? 'd-none' : ''}">
                                            {if $extended.pass_one_img}
                                                <a href="{$extended.pass_one_img}" target="_blank">
                                                    Скан основного разворота паспорта
                                                </a>
                                            {else}
                                                <a>Скан основного разворота паспорта не загружен</a>
                                            {/if}
                                        </li>
                                        <li class="{$legal_form === 'ИП' ? 'd-none' : ''}">
                                            {if $extended.pass_two_img}
                                                <a href="{$extended.pass_two_img}" target="_blank">
                                                    Скан разворота паспорта с пропиской
                                                </a>
                                            {else}
                                                <a>Скан разворота паспорта с пропиской не загружен</a>
                                            {/if}
                                        </li>
                                        <li class="{$legal_form === 'ИП' ? 'd-none' : ''}">
                                            {if $extended.insurance_img}
                                                <a href="{$extended.insurance_img}" target="_blank">
                                                    Скан лицевой стороны СНИЛС
                                                </a>
                                            {else}
                                                <a>Скан лицевой стороны СНИЛС не загружен</a>
                                            {/if}
                                        </li>
                                        <li class="{$legal_form === 'ИП' ? '' : 'd-none'}">
                                            {if $extended.certificate_img}
                                                <a href="{$extended.certificate_img}" target="_blank">
                                                    Свидетельство о регистрации ИП
                                                </a>
                                            {else}
                                                <a>Свидетельство о регистрации ИП не загружено</a>
                                            {/if}
                                        </li>
                                        <li class="{$legal_form === 'ИП' ? '' : 'd-none'}">
                                            {if $extended.inn_img}
                                                <a href="{$extended.inn_img}" target="_blank">
                                                    Скан ИНН
                                                </a>
                                            {else}
                                                <a>Скан ИНН не загружен</a>
                                            {/if}
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="columns">
                        <div class="column col-6 sm-col-12">
                            <div class="designer-card">
                                <div class="designer-card__content">
                                    <h3>Реквизиты карты:</h3>
                                    <ul class="designer-card__info">
                                        <li>
                                            Расчётный
                                            счёт: {$extended.rs ?'<span data-copy title="Нажмите для копирования">'~$extended.rs~'</span>': '<span class="red">Не указано</span>'}
                                        </li>
                                        <li>
                                            БИК: {$extended.bik ?'<span data-copy title="Нажмите для копирования">'~$extended.bik~'</span>': '<span class="red">Не указано</span>'}
                                        </li>
                                    </ul>
                                    <textarea class="input textarea mt-20" data-copy title="Нажмите для копирования">{$extended.card_data}</textarea>
                                </div>
                            </div>
                        </div>
                        <form data-si-form class="column col-6 sm-col-12">
                            <input type="hidden" name="id" value="{$id}">
                            <div class="designer-card">
                                <div class="designer-card__content">
                                    <ul class="designer-card__info">
                                        <li>
                                            <span><h3>Номер ЛК:</h3></span>
                                            <input type="text" class="input" name="profile_num" value="{$profile_num}">
                                        </li>
                                    </ul>
                                </div>
                                <div class="designer-card__content">
                                    <h3>Причина отказа:</h3>
                                    <textarea class="input textarea" name="comment"
                                              placeholder="Если дизайнер не прошёл модерацию, обязательно укажите причину">{$comment}</textarea>
                                </div>
                                <div class="designer-card__content">
                                    <ul class="designer-card__footer">
                                        <li>
                                            <label class="checkbox-label">
                                                <input type="checkbox" name="selected_id[]" value="{$id}" form="listActionUsers" class="checkbox">
                                                <span class="checkbox-text"></span>
                                            </label>
                                        </li>
                                        <li>
                                            <div class="js-custom-select select-pill">
                                                {set $statuses = ('statuses' | placeholder)}
                                                {set $allow = $statuses['designer'][$status]['allow']}
                                                <select class="" name="status">
                                                    {foreach $statuses['designer'] as $id => $data}
                                                        {if ($id in list $allow) || ($status == $id)}
                                                            <option value="{$id}"
                                                                    data-mpc-attr="{$status == $id ? 'selected' : ''}">
                                                                {$data.caption}
                                                            </option>
                                                        {/if}
                                                    {/foreach}
                                                </select>
                                            </div>
                                        </li>
                                        <li>
                                            <button class="btn btn--small" type="button" data-si-event="click" data-si-preset="updateUser">Отправить</button>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </form>
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

            <div id="modal-excel" aria-hidden="true" class="modal">
                <form id="generateReport" data-si-form="generateReport" data-si-nosave class="modal-main">
                    <div class="modal-close" data-modal-close></div>
                    <div class="modal-content scrollbar">
                        <h2>Выберите данные для отображения в файле.</h2>
                        <div class="columns-list columns-list-2">
                            <input type="hidden" name="className" value="modUser">
                            <input type="checkbox" name="captions[id][]" value="ID" checked class="v_hidden">
                            <input type="checkbox" name="names[]" value="id" checked class="v_hidden">
                            {set $groups = $_modx->runSnippet('@FILE snippets/designer/snippet.getuserfields.php', [])}
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

            <div id="modal-search" aria-hidden="true" data-mpc-chunk="common/search_modal.tpl" data-mpc-include="1" class="modal modal-main_sm">
                <div class="modal-main">
                    <div class="modal-close" data-modal-close></div>
                    <div class="modal-content">
                        <div class="input-group">
                            <label class="input-label">Введите запрос</label>
                            <input type="text" class="input" name="query" data-query form="filterForm" value="{$.get.query}">
                            <small class="error" data-si-error="query"></small>
                        </div>
                    </div>
                    <div class="modal-footer center">
                        <button type="submit" form="filterForm" class="btn" data-modal-close>Найти</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>