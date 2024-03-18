<!--##{"templatename":"Авторизация","pagetitle":"Страница Авторизации","icon":"icon-sign-in"}##-->

<!-- /usr/local/php/php-7.4/bin/php -d display_errors -d error_reporting=E_ALL /home/host1860015/art-sites.ru/htdocs/customfactory/core/components/migxpageconfigurator/console/mgr_tpl.php web auth.tpl -->

<div id="{$id}" data-mpc-section="auth" data-mpc-name="Авторизация" class="showcase">
    <div class="container">
        <div class="login-form">
            ##set $userData = '!ActivateUser' | snippet: []}
            <div data-mpc-unwrap="1" data-mpc-chunk="common/ident_nav.tpl" data-mpc-include="1" data-mpc-copy="register.tpl"></div>

            <form class="" action="#" method="post" data-si-form="authForm" data-si-preset="auth">
                <div class="login-form__layout">
                    <div class="login-form__content col-6 md-col-12">
                        <div class="form-group">
                            <small class="red" data-si-error="errorLogin"></small>
                            <input type="email" name="email" class="input" placeholder="E-mail">
                            <small class="red" data-si-error="email"></small>
                        </div>
                        <div class="form-group">
                            <input type="password" name="password" class="input" placeholder="Пароль">
                            <small class="red" data-si-error="password"></small>
                        </div>
                    </div>
                    <div class="login-form__content col-6 md-col-12">
                        <div class="form-group">
                            <div class="login-form__info" data-mpc-field="content">
                                Если вы забыли пароль, воспользуйтесь <a href="{26 | url}">формой сброса пароля</a>.
                            </div>
                        </div>

                        <div class="form-info" data-mpc-chunk="common/form_links.tpl" data-mpc-include="1" data-mpc-copy="register.tpl">
                            Нажимая кнопку “Регистрация”, я принимаю условия <a href="polzovatelskoe-soglashenie">Пользовательского соглашения</a>,
                            даю согласие на обработку персональных данных в соответствии с <a href="politika-konfidenczialnosti">Политикой</a>.
                        </div>
                    </div>
                </div>
                <div class="form-footer">
                    <button type="submit" class="btn">Войти</button>
                </div>
            </form>
        </div>
    </div>
</div>