<div class="designer-item" id="designer-{$id}">
                    <div class="columns">
                        <div class="column col-6 sm-col-12">
                            <div class="designer-card">
                                <div class="designer-card__content">
                                    <div class="profile-header profile-header--card">
                                        {set $photo = $photo ?: 'assets/project_files/img/cabinet/no-photo.jpg'}
                                        <div class="profile-header__avatar">
                                            <img src="{$photo}" alt="">
                                        </div>
                                        {set $name = [$extended['surname'], $extended['name'], $extended['fathername']]}
                                        <div class="profile-header__name">{($name | count > 0)? ($name | join: ' ') : $username}</div>
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
                                            оферты: {$extended[$offerPageKey] ? '<span data-copy title="Нажмите для копирования">'~$extended[('offerPageKey' | placeholder)]~'</span>' : '<span class="red">Не принята</span>'}
                                        </li>
                                        <li>
                                            {if $address_fact}
                                                {if $zip_fact}
                                                    {set $address_fact = '<span data-copy title="Нажмите для копирования">'~$zip_fact~', '~$address_fact~'</span>'}
                                                {else}
                                                    {set $address_fact = '<span data-copy title="Нажмите для копирования">'~$address_fact~'</span>'}
                                                {/if}
                                            {else}
                                                {set $address_fact = '<span class="red">Не указано</span>'}
                                            {/if}
                                            Фактический адрес: {$address_fact}
                                        </li>
                                        <li>
                                            {if $address}
                                                {if $zip}
                                                    {set $address = '<span data-copy title="Нажмите для копирования">'~$zip~', '~$address~'</span>'}
                                                {else}
                                                    {set $address = '<span data-copy title="Нажмите для копирования">'~$address~'</span>'}
                                                {/if}
                                            {else}
                                                {set $address = '<span class="red">Не указано</span>'}
                                            {/if}
                                            Адрес для корреспонденции: {$address}
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
                                            {if $extended.pass_where}
                                                {if $extended.pass_date}
                                                    {set $extended.pass_where = '<span data-copy title="Нажмите для копирования">'~$extended.pass_date~', '~$extended.pass_where~'</span>'}
                                                {else}
                                                    {set $extended.pass_where = '<span data-copy title="Нажмите для копирования">'~$extended.pass_where~'</span>'}
                                                {/if}
                                            {else}
                                                {set $extended.pass_where = '<span class="red">Не указано</span>'}
                                            {/if}
                                            Кем и когда выдан: {$extended.pass_where}
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
                                            ИНН: {$inn ?'<span data-copy title="Нажмите для копирования">'~($inn | replace: ' ': '')~'</span>': '<span class="red">Не указано</span>'}
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
                                    <textarea class="input textarea" name="comment" placeholder="Если дизайнер не прошёл модерацию, обязательно укажите причину">{$comment}</textarea>
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
                                                {set $statuses = $statuses ?: ('statuses' | placeholder)}
                                                {set $allow = $statuses['designer'][$status]['allow']}
                                                <select class="" name="status">
                                                    {foreach $statuses['designer'] as $id => $data}
                                                        {if ($id in list $allow) || ($status == $id)}
                                                            <option value="{$id}" {$status == $id ? 'selected' : ''}>
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