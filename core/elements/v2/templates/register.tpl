<!--##{"templatename":"Регистрация","pagetitle":"Страница Регистрации","icon":"icon-check"}##-->

<!-- /usr/local/php/php-7.4/bin/php -d display_errors -d error_reporting=E_ALL /home/host1860015/art-sites.ru/htdocs/customfactory/core/components/migxpageconfigurator/console/mgr_tpl.php web register.tpl -->

<div id="{$id}" data-mpc-section="register" data-mpc-name="Регистрация" class="showcase">
    <div class="container">
        <div class="login-form">

            <div data-mpc-unwrap="1" data-mpc-chunk="common/ident_nav.tpl" data-mpc-include="1">
                <ul class="login-form__tabs" data-mpc-snippet="pdoResources|ident_nav" data-mpc-symbol="{ ">
                    <li data-mpc-chunk="pdoresources/ident_nav/item.tpl"><a href="{$uri}" class="##$_modx->resource.id === {$id} ? 'active' : ''}">{$menutitle?:$pagetitle}</a></li>
                </ul>
            </div>

            <form class="" action="#" method="post" data-si-form="registerForm" data-si-preset="register">
                <input type="hidden" name="status" value="3">
                <input type="hidden" name="extended[offer]" value="Нет">
                <input type="hidden" name="createdon" value="##'' | date: 'd.m.Y H:i:s'}">
                <div class="login-form__layout">
                    <div class="login-form__content col-6 md-col-12">
                        <div class="form-group">
                            <input type="text" class="input" name="fullname" placeholder="Имя">
                            <small class="red" data-si-error="fullname"></small>
                        </div>
                        <div class="form-group">
                            <input type="email" name="email" class="input" placeholder="E-mail" value="">
                            <small class="red" data-si-error="email"></small>
                        </div>
                        <div class="form-group">
                            <input type="tel" name="phone" class="input" placeholder="Телефон" value="">
                            <small class="red" data-si-error="phone"></small>
                        </div>
                        <div class="form-group">
                            <input type="password" name="password" class="input" placeholder="Пароль">
                            <small class="red" data-si-error="password"></small>
                        </div>
                    </div>
                    <div class="login-form__content col-6 md-col-12">

                        <div class="form-group">
                            <div class="login-form__info" data-mpc-field="content">
                                Вы можете указать свой пароль, или оставить это поле пустым и тогда он будет сгенерирован автоматически.
                            </div>
                        </div>

                        <div class="form-info" data-mpc-chunk="common/form_links.tpl" data-mpc-include="1">
                            Нажимая кнопку “Регистрация”, я принимаю условия <a href="polzovatelskoe-soglashenie">Пользовательского соглашения</a>,
                            даю согласие на обработку персональных данных в соответствии с <a href="politika-konfidenczialnosti">Политикой</a>.
                        </div>
                    </div>
                </div>
                <div class="form-footer">
                    <button type="submit" class="btn">Регистрация</button>
                </div>
            </form>
        </div>
    </div>
</div>