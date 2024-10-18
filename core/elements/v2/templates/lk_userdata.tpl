<!--##{"templatename":"Личные данные","pagetitle":"Страница Личных данных","icon":"icon-user","extends":"12"}##-->

<!-- /usr/local/php/php-7.4/bin/php /home/host1860015/art-sites.ru/htdocs/customfactory/core/components/migxpageconfigurator/console/mgr_tpl.php web lk_userdata.tpl -->
<!-- php7.4 www/core/components/migxpageconfigurator/console/mgr_tpl.php web lk_userdata.tpl -->
<div id="{$id}" data-mpc-section="userdata" data-mpc-name="Данные пользователя">
    <form data-si-preset="dataedit" data-si-form="userData" enctype="multipart/form-data">
        <input type="hidden" name="status" value="1">
        <div class="container-small">
            ##set $extended = $_modx->user.extended}
            <div class="profile-header">
                <div data-modal-show="#modal-load-avatar" class="profile-header__avatar">
                    ##set $photo = 'assets/project_files/img/cabinet/no-photo.jpg'}
                    ##if $_modx->user.photo}
                    ##set $photo = $_modx->user.photo}
                    ##/if}
                    <img src="##$photo}" class="user-avatar" alt="">
                </div>
                <div class="profile-header__name">
                    ##$_modx->user.extended.surname} ##$_modx->user.extended.name}
                </div>
            </div>

            <div class="profile-number">
                <div class="profile-number__icon">№</div>
                <div class="profile-number__text">
                    Номер вашего личного кабинета: ##$_modx->user.profile_num}
                </div>
            </div>

        </div>

        <div class="profile-items">

            <!--Учётная запись-->
            <div class="profile-item">

                <h2>Учётная запись</h2>

                <div class="columns">
                    <div class="column col-8 md-col-12">

                        <div class="container-small">

                            <div>
                                <div class="input-group">
                                    <label class="input-label">Логин</label>
                                    <input type="text" class="input" name="email" value="##$_modx->user.email}" readonly>
                                </div>

                                <button type="button" data-modal-show="#modal-change-pass" class="btn btn--small">Сменить пароль</button>
                            </div>

                        </div>

                    </div>
                    <div class="column col-4 md-col-12 md-order-1">
                        <div class="blockquote ##$_modx->user.status == 2 ? '' : 'd-none'}">
                            Ваши данные успешно прошли модерацию. Для внесения изменений обратитесь в <a href="{51973 | resource: 'content'}">техническую поддержку</a>.
                        </div>
                        <div class="blockquote blockquote_warning ##$_modx->user.status == 1 ? '' : 'd-none'}">
                            Ваши данные проходят модерацию. О результатах Вы получите уведомление.
                        </div>
                        <div class="blockquote ##$_modx->user.status == 3 ? '' : 'd-none'}">
                            <p>Ваши данные не прошли модерацию.</p>

                            ##if $_modx->user.comment}
                            <p><strong>Причина:</strong> ##$_modx->user.comment}</p>
                            ##/if}

                            <p>ВНИМАНИЕ! После успешной проверки исправить данные можно будет только обратившись в
                                <a href="{51973 | resource: 'content'}">техническую поддержку</a>.</p>
                        </div>
                    </div>
                </div>


            </div>

            <!--Личные данные-->
            <div class="profile-item">
                <div class="container-small">
                    <h2>Личные данные</h2>

                    ##set $names = $_modx->user.fullname | split: ' '}
                    <div class="input-group">
                        <label class="input-label">Фамилия*</label>
                        <input type="text" class="input" name="extended[surname]" value="##$extended[surname]?:$names[0]}"
                               data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                        <small class="error" data-si-error="extended[surname]"></small>
                    </div>

                    <div class="input-group">
                        <label class="input-label">Имя*</label>
                        <input type="text" class="input" name="extended[name]" value="##$extended[name]?:$names[1]}"
                               data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                        <small class="error" data-si-error="extended[name]"></small>
                    </div>

                    <div class="input-group">
                        <label class="input-label">Отчество*</label>
                        <input type="text" class="input" name="extended[fathername]" value="##$extended[fathername]?:$names[2]}"
                               data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                        <small class="error" data-si-error="extended[fathername]"></small>
                    </div>

                    <div class="input-group">
                        <label class="input-label">
                            Телефон*
                            <small>Телефон нужен для связи и выплаты денег</small>
                        </label>
                        <input type="text" class="input" name="phone" placeholder="%2B7(9" value="##$_modx->user.phone}"
                               data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                        <small class="error" data-si-error="phone"></small>
                    </div>
                    ##if $_modx->user.status != 2}
                    <div class="input-group">
                        <label class="input-label">
                            Адреса*
                            <small>Напишите адрес для почтовой корреспонденции</small>
                        </label>

                        <div class="columns">
                            <div class="column col-4 md-col-12">
                                <input type="text" class="input" placeholder="Индекс" name="zip" value="##$_modx->user.zip}" data-match-recepient="zip_fact"
                                       data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                                <small class="error" data-si-error="zip"></small>
                            </div>
                            <div class="column col-8 md-col-12">
                                <input type="text" class="input" placeholder="Адрес" name="address" value="##$_modx->user.address}" data-match-recepient="address_fact"
                                       data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                                <small class="error" data-si-error="address"></small>
                            </div>
                        </div>
                    </div>

                    <div class="input-group">
                        <label class="input-label">
                            <small>Напишите адрес фактического проживания</small>
                        </label>
                        <div class="columns">
                            <div class="column col-4 md-col-12">
                                <input type="text" class="input" placeholder="Индекс" name="zip_fact" value="##$_modx->user.zip_fact}"
                                       data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                                <small class="error" data-si-error="zip_fact"></small>
                            </div>
                            <div class="column col-8 md-col-12">
                                <input type="text" class="input" placeholder="Адрес" name="address_fact" value="##$_modx->user.address_fact}"
                                       data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                                <small class="error" data-si-error="address_fact"></small>
                            </div>
                        </div>
                        <label class="checkbox-label" style="margin-top:30px;">
                            ##if $_modx->user.address_fact == $_modx->user.address && $_modx->user.address_fact && $_modx->user.address}
                            ##set $checked = 'checked'}
                            ##/if}
                            <input type="checkbox" class="checkbox" data-match-donor="address,zip"
                                   data-mpc-attr="##$checked} ##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                            <span class="checkbox-text">Адрес для корреспонденции и Фактический адрес совпадают</span>
                        </label>
                    </div>
                    ##/if}
                </div>
            </div>

            ##if $_modx->user.status != 2}
            <!--Организационно правовая форма-->
            <div class="profile-item">

                <div class="container-small">
                    <h2>Организационно-правовая форма</h2>

                    <div class="input-group">
                        Сервис работает с самозанятыми и ИП. Как оформить самозанятость или стать ИП, читайте в разделе помощь
                    </div>

                    <div class="columns">
                        <div class="column col-6 md-col-12">
                            <label class="checkbox-label">
                                <input type="radio" class="checkbox" name="legal_form" value="Самозанятый"
                                       data-mpc-attr="##$_modx->user.legal_form == 'Самозанятый' ? 'checked' : ''} ##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                                <span class="checkbox-text radio-text">Самозанятый</span>
                            </label>
                        </div>
                        <div class="column col-6 md-col-12">
                            <label class="checkbox-label">
                                <input type="radio" class="checkbox" name="legal_form" value="ИП"
                                       data-mpc-attr="##$_modx->user.legal_form == 'Самозанятый' ? '' : 'checked'} ##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                                <span class="checkbox-text radio-text">ИП</span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>

            <!--Данные ОПФ-->
            <div class="profile-items" style="display:block;">

                <div class="profile-item profile-item--small">
                    <h3 data-legal-form="Самозанятый" class="##$_modx->user.legal_form == 'Самозанятый' ? '' : 'd-none'}">Данные о самозанятости</h3>
                    <h3 data-legal-form="ИП" class="##$_modx->user.legal_form == 'Самозанятый' ? 'd-none' : ''}">Данные об ИП</h3>

                    <div class="columns">
                        <div class="column col-6 md-col-12">

                            <div class="container-small">

                                <div class="input-group ##$_modx->user.legal_form == 'Самозанятый' ? '' : 'd-none'}" data-legal-form="Самозанятый">
                                    <label class="input-label">Номер справки о постановке на учет в качестве плательщика «Налога на профессиональный доход»*</label>
                                    <input type="text" class="input" name="extended[certificate_num]" value="##$extended[certificate_num]}"
                                           data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                                    <small class="error" data-si-error="extended[certificate_num]"></small>
                                </div>

                                <div class="input-group ##$_modx->user.legal_form == 'Самозанятый' ? '' : 'd-none'}" data-legal-form="Самозанятый">
                                    <label class="input-label">Дата выдачи справки о постановке на учёт в качестве плательщика «Налога на профессиональный доход»*</label>
                                    <input type="text" class="input" name="extended[certificate_date]" value="##$extended[certificate_date]}"
                                           data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                                    <small class="error" data-si-error="extended[certificate_date]"></small>
                                </div>

                                <div class="input-group ##$_modx->user.legal_form == 'Самозанятый' ? '' : 'd-none'}" data-legal-form="Самозанятый">
                                    <label class="input-label">Номер СНИЛС*</label>
                                    <input type="text" class="input" name="extended[insurance]" value="##$extended[insurance]}"
                                           placeholder="11 цифр"
                                           data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                                    <small class="error" data-si-error="extended[insurance]"></small>
                                </div>

                                <div class="input-group ##$_modx->user.legal_form == 'Самозанятый' ? 'd-none' : ''}" data-legal-form="ИП">
                                    <label class="input-label">Адрес регистрации ИП*</label>
                                    <input type="text" class="input" name="extended[address_ip]" value="##$extended[address_ip]}"
                                           data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                                    <small class="error" data-si-error="extended[address_ip]"></small>
                                    <label class="checkbox-label" style="margin-top:30px;">
                                        ##if $extended.address_ip == $extended.pass_address && $extended.pass_address && $extended.address_ip}
                                        ##set $checked = 'checked'}
                                        ##/if}
                                        <input type="checkbox" class="checkbox" data-match-donor="extended[pass_address]"
                                               data-mpc-attr="##$checked} ##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                                        <span class="checkbox-text">Адреса регистрации ИП и в паспорте совпадают</span>
                                    </label>
                                </div>


                                <div class="input-group ##$_modx->user.legal_form == 'Самозанятый' ? 'd-none' : ''}" data-legal-form="ИП">
                                    <label class="input-label">ОГРНИП*</label>
                                    <input type="text" class="input" name="extended[ogrnip]" value="##$extended[ogrnip]}"
                                           data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                                    <small class="error" data-si-error="extended[ogrnip]"></small>
                                </div>

                                <div class="input-group ##$_modx->user.legal_form == 'Самозанятый' ? 'd-none' : ''}" data-legal-form="ИП">
                                    <label class="input-label">ИНН*</label>
                                    <input type="text" class="input" name="inn_ip" value="##$_modx->user.inn}"
                                           placeholder="12 цифр"
                                           data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                                    <small class="error" data-si-error="inn_ip"></small>
                                </div>

                                <div class="input-group ##$_modx->user.legal_form == 'Самозанятый' ? '' : 'd-none'}" data-legal-form="Самозанятый">
                                    <label class="input-label">ИНН*</label>
                                    <input type="text" class="input" name="inn_self" value="##$_modx->user.inn}"
                                           placeholder="12 цифр"
                                           data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                                    <small class="error" data-si-error="inn_self"></small>
                                </div>

                                <div class="input-group">
                                    ##set $offerPageKey = 'offer'~(51976 | resource: 'introtext')}
                                    ##set $offerDate = $extended[$offerPageKey]}
                                    <label class="input-label">Дата принятия оферты*</label>
                                    <input type="text" readonly class="input" value="##$offerDate}">
                                </div>
                            </div>

                        </div>
                        <div class="column col-3 md-col-12 ##$_modx->user.legal_form == 'Самозанятый' ? '' : 'd-none'}" data-legal-form="Самозанятый">
                            <div class="profile-document">
                                <div class="profile-document__text">
                                    Пример справки о постановке на учёт в качестве плательщика «Налога на профессиональный доход»
                                </div>
                                <div class="profile-document__image">
                                    <a href="assets/project_files/v2/img/lk/profile-document.jpg" data-fancybox>
                                        <img src="assets/project_files/v2/img/lk/profile-document.jpg" alt="">
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!--Паспорт-->
            <div class="profile-item">
                <h2>Паспортные данные <small>Нужны для заключения договора</small></h2>

                <div class="container-small">
                    <div class="input-group">
                        <div class="columns">
                            <div class="column col-6 md-col-12">
                                <label class="input-label">Серия*</label>
                                <input type="text" class="input" name="pass_series" value="##$_modx->user.pass_series}"
                                       data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                                <small class="error" data-si-error="pass_series"></small>
                            </div>
                            <div class="column col-6 md-col-12">
                                <label class="input-label">Номер*</label>
                                <input type="text" class="input" name="pass_num" value="##$_modx->user.pass_num}"
                                       data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                                <small class="error" data-si-error="pass_num"></small>
                            </div>
                        </div>
                    </div>

                    <div class="input-group">
                        <label class="input-label">Кем и когда выдан*</label>
                        <div class="columns">
                            <div class="column col-6 md-col-12">
                                <input type="text" class="input" name="extended[pass_date]" value="##$extended[pass_date]}" placeholder="Дата выдачи"
                                       data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                                <small class="error" data-si-error="extended[pass_date]"></small>
                            </div>
                            <div class="column col-6 md-col-12">
                                <input type="text" class="input" name="extended[pass_code]" value="##$extended[pass_code]}" placeholder="Код подразделения"
                                       data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                                <small class="error" data-si-error="extended[pass_code]"></small>
                            </div>
                            <div class="column col-12">
                                <input type="text" class="input" name="extended[pass_where]" value="##$extended[pass_where]}" placeholder="Орган, выдавший паспорт"
                                       data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                                <small class="error" data-si-error="extended[pass_where]"></small>
                            </div>
                        </div>
                    </div>
                    <div class="input-group">
                        <label class="input-label">Адрес регистрации*</label>
                        <input type="text" class="input" name="extended[pass_address]" value="##$extended[pass_address]}" data-match-recepient="extended[address_ip]"
                               data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                        <small class="error" data-si-error="extended[pass_address]"></small>
                    </div>

                    <div class="input-group">
                        <label class="input-label">Дата рождения*</label>
                        <input type="text" class="input" name="dob" value="##$_modx->user.dob? ($_modx->user.dob | date: 'd.m.Y') :''}"
                               data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                        <small class="error" data-si-error="dob"></small>
                    </div>
                </div>
            </div>

            <!--Реквизиты-->
            <div class="profile-item">

                <div class="columns">
                    <div class="column col-6 md-col-12">

                        <div class="container-small">

                            <h2>Полные реквизиты для получения оплаты* <small>Подробнее о том, какие реквизиты нужно указать, смотрите в разделе "Частые вопросы"</small></h2>

                            <div class="input-group">
                                <label class="input-label">Расчетный счет*</label>
                                <input type="text" class="input" name="extended[rs]" value="##$extended[rs]}"
                                       data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                                <small class="error" data-si-error="extended[rs]"></small>
                            </div>

                            <div class="input-group">
                                <label class="input-label">БИК*</label>
                                <input type="text" class="input" name="extended[bik]" value="##$extended[bik]}"
                                       data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">
                                <small class="error" data-si-error="extended[bik]"></small>
                            </div>

                            <textarea class="input textarea" name="extended[card_data]" data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}"
                                      placeholder="Получатель, Банк получателя, Корр. счёт, ИНН, КПП, SWIFT-код">##$extended[card_data]}</textarea>
                            <small class="error" data-si-error="extended[card_data]"></small>
                        </div>

                    </div>
                    <div class="column column_end col-6 md-col-12">
                        <div class="profile-document">
                            <div class="profile-document__text">
                                Пример заполнения реквизитов для получения оплаты
                            </div>
                            <div class="profile-document__content">
                                Получатель: Иванова Светлана Ивановна <br>
                                Банк получателя: СЕВЕРО-ЗАПАДНЫЙ БАНК ПАО СБЕРБАНК <br>
                                Корр. счёт: 11111111111111111111 <br>
                                ИНН: 11111111 <br>
                                КПП: 111111111 <br>
                                SWIFT-код: AAAAAA1A
                            </div>
                        </div>

                    </div>
                </div>

            </div>
            ##/if}

            <!--Документы-->
            <div class="profile-item">

                <div class="container-small">
                    <h2>Документы</h2>
                    ##if !$extended.selfemployed_img}
                    <div class="input-group ##$_modx->user.legal_form == 'Самозанятый' ? '' : 'd-none'}" data-legal-form="Самозанятый" data-si-preset="selfemployed_img"
                         data-si-form="certUploadForm">
                        <div data-fu-wrap>
                            <label class="input-label">Справка о постановке на учет в качестве плательщика «Налога на профессиональный доход»*</label>
                            <input type="hidden" name="extended[selfemployed_img]" data-fu-list>
                            <div data-fu-progress=""></div>
                            <div class="file">
                                <input type="file" data-fu-field name="selfemployed_img" data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}"
                                       class="file-form__file">
                                <div class="file-text">загрузите фотографию</div>
                            </div>
                            <template data-fu-tpl>
                                <button type="button" class="btn file-list__btn" data-fu-path="$path">$filename&nbsp;x</button>
                            </template>
                        </div>
                        <small class="error" data-si-error="extended[selfemployed_img]"></small>
                    </div>
                    ##else}
                    <input type="hidden" name="extended[selfemployed_img]" data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}"
                           value="##$extended.selfemployed_img}">
                    <p class="input-label">Справка о постановке на учет в качестве плательщика «Налога на профессиональный доход» уже загружена.</p>
                    ##/if}

                    ##if !$extended.pass_one_img}
                    <div class="input-group ##$_modx->user.legal_form == 'Самозанятый' ? '' : 'd-none'}" data-legal-form="Самозанятый" data-si-preset="pass_one_img"
                         data-si-form="passOneUploadForm">
                        <div data-fu-wrap>
                            <label class="input-label">Скан основного разворота паспорта*</label>
                            <input type="hidden" name="extended[pass_one_img]" data-fu-list>
                            <div data-fu-progress=""></div>
                            <div class="file">
                                <input type="file" data-fu-field name="pass_one_img" data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}"
                                       class="file-form__file">
                                <div class="file-text">загрузите фотографию</div>
                            </div>
                            <template data-fu-tpl>
                                <button type="button" class="btn file-list__btn" data-fu-path="$path">$filename&nbsp;x</button>
                            </template>
                        </div>
                        <small class="error" data-si-error="extended[pass_one_img]"></small>
                    </div>
                    ##else}
                    <input type="hidden" name="extended[pass_one_img]" data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}"
                           value="##$extended.pass_one_img}">
                    <p class="input-label">Скан основного разворота паспорта уже загружен.</p>
                    ##/if}

                    ##if !$extended.pass_two_img}
                    <div class="input-group ##$_modx->user.legal_form == 'Самозанятый' ? '' : 'd-none'}" data-legal-form="Самозанятый" data-si-preset="pass_two_img"
                         data-si-form="passTwoUploadForm">
                        <div data-fu-wrap>
                            <label class="input-label">Скан разворота паспорта с пропиской*</label>
                            <input type="hidden" name="extended[pass_two_img]" data-fu-list>
                            <div data-fu-progress=""></div>
                            <div class="file">
                                <input type="file" data-fu-field name="pass_two_img" data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}"
                                       class="file-form__file">
                                <div class="file-text">загрузите фотографию</div>
                            </div>
                            <template data-fu-tpl>
                                <button type="button" class="btn file-list__btn" data-fu-path="$path">$filename&nbsp;x</button>
                            </template>
                        </div>
                        <small class="error" data-si-error="extended[pass_two_img]"></small>
                    </div>
                    ##else}
                    <input type="hidden" name="extended[pass_two_img]" data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}"
                           value="##$extended.pass_two_img}">
                    <p class="input-label">Скан разворота паспорта с пропиской уже загружен.</p>
                    ##/if}

                    ##if !$extended.insurance_img}
                    <div class="input-group ##$_modx->user.legal_form == 'Самозанятый' ? '' : 'd-none'}" data-legal-form="Самозанятый" data-si-preset="insurance_img"
                         data-si-form="insuranceUploadForm">
                        <div data-fu-wrap>
                            <label class="input-label">Скан лицевой стороны СНИЛС*</label>
                            <input type="hidden" name="extended[insurance_img]" data-fu-list>
                            <div data-fu-progress=""></div>
                            <div class="file">
                                <input type="file" data-fu-field name="insurance_img" data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}"
                                       class="file-form__file">
                                <div class="file-text">загрузите фотографию</div>
                            </div>
                            <template data-fu-tpl>
                                <button type="button" class="btn file-list__btn" data-fu-path="$path">$filename&nbsp;x</button>
                            </template>
                        </div>
                        <small class="error" data-si-error="extended[insurance_img]"></small>
                    </div>
                    ##else}
                    <input type="hidden" name="extended[insurance_img]" data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}"
                           value="##$extended.insurance_img}">
                    <p class="input-label">Скан лицевой стороны СНИЛС уже загружен.</p>
                    ##/if}


                    ##if !$extended.certificate_img}
                    <div class="input-group ##$_modx->user.legal_form == 'Самозанятый' ? 'd-none' : ''}" data-legal-form="ИП" data-si-preset="certificate_img"
                         data-si-form="certificateUploadForm">
                        <div data-fu-wrap>
                            <label class="input-label">Свидетельство о регистрации ИП*</label>
                            <input type="hidden" name="extended[certificate_img]" data-fu-list>
                            <div data-fu-progress=""></div>
                            <div class="file">
                                <input type="file" data-fu-field name="certificate_img" data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}"
                                       class="file-form__file">
                                <div class="file-text">загрузите фотографию</div>
                            </div>
                            <template data-fu-tpl>
                                <button type="button" class="btn file-list__btn" data-fu-path="$path">$filename&nbsp;x</button>
                            </template>
                        </div>
                        <small class="error" data-si-error="extended[certificate_img]"></small>
                    </div>
                    ##else}
                    <input type="hidden" name="extended[certificate_img]" data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}"
                           value="##$extended.certificate_img}">
                    <p class="input-label">Свидетельство о регистрации ИП уже загружено.</p>
                    ##/if}

                    ##if !$extended.inn_img}
                    <div class="input-group ##$_modx->user.legal_form == 'Самозанятый' ? 'd-none' : ''}" data-legal-form="ИП" data-si-preset="inn_img"
                         data-si-form="innUploadForm">
                        <div data-fu-wrap>
                            <label class="input-label">Скан ИНН*</label>
                            <input type="hidden" name="extended[inn_img]" data-fu-list>
                            <div data-fu-progress=""></div>
                            <div class="file">
                                <input type="file" data-fu-field name="inn_img" data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}"
                                       class="file-form__file">
                                <div class="file-text">загрузите фотографию</div>
                            </div>
                            <template data-fu-tpl>
                                <button type="button" class="btn file-list__btn" data-fu-path="$path">$filename&nbsp;x</button>
                            </template>
                        </div>
                        <small class="error" data-si-error="extended[inn_img]"></small>
                    </div>
                    ##else}
                    <input type="hidden" name="extended[inn_img]" data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}" value="##$extended.inn_img}">
                    <p class="input-label">Скан ИНН уже загружен.</p>
                    ##/if}
                </div>
            </div>
        </div>

        <div class="btn-footer">
            <button type="submit" class="btn btn--small" data-mpc-attr="##($_modx->user.status in list [1,2]) ? 'disabled' : ''}">На модерацию</button>
        </div>
    </form>
    <div id="modal-change-pass" aria-hidden="true" class="modal">
        <form data-si-preset="editpass" data-si-form="editpassForm" class="modal-main modal-main_sm">
            <div class="modal-close" data-modal-close></div>
            <div class="modal-title">Изменение пароля</div>
            <div class="input-group">
                <label class="input-label">Введите новый пароль</label>
                <input type="password" class="input" name="password" value="">
            </div>
            <div class="input-group">
                <label class="input-label">Подтвердите пароль</label>
                <input type="password" class="input" name="password_confirm" value="">
            </div>

            <div class="modal-footer center">
                <button type="submit" class="btn">Сохранить</button>
            </div>
        </form>
    </div>
    <div id="modal-load-avatar" aria-hidden="true" class="modal">
        <form data-si-preset="add_avatar" data-si-form="avatarForm" enctype="multipart/form-data" class="modal-main modal-main_sm">
            <div class="modal-close" data-modal-close></div>
            <div class="modal-title">Изменить фото профиля</div>
            <div class="input-group" data-fu-wrap data-si-preset="user_photo" data-si-nosave="">
                <input type="hidden" name="photo" data-fu-list>
                <div data-fu-progress=""></div>
                <div class="file">
                    <input type="file" name="avatar" data-fu-field class="file-form__file">
                    <div class="file-text">загрузите фотографию</div>
                </div>
                <template data-fu-tpl>
                    <button type="button" class="btn file-list__btn" data-fu-path="$path">$filename&nbsp;x</button>
                </template>
            </div>
            <div class="modal-footer center">
                <button type="submit" class="btn">Сохранить</button>
            </div>
        </form>
    </div>
</div>
