<!--##{"templatename":"Сброс пароля","pagetitle":"Страница Сброса пароля","icon":"icon-wrench"}##-->

<!-- /usr/local/php/php-7.4/bin/php -d display_errors -d error_reporting=E_ALL /home/host1860015/art-sites.ru/htdocs/customfactory/core/components/migxpageconfigurator/console/mgr_tpl.php web reset_pass.tpl -->

<div id="{$id}" data-mpc-section="reset_pass" data-mpc-name="Сброс пароля" class="showcase">
    <div class="container">
        <div class="login-form">

            <div data-mpc-unwrap="1" data-mpc-chunk="common/ident_nav.tpl" data-mpc-include="1" data-mpc-copy="register.tpl"></div>

            <form class="" action="#" method="post" data-si-form="resetForm" data-si-preset="forgot">
                <div class="login-form__layout">
                    <div class="login-form__content col-6 md-col-12">
                        <div class="form-group">
                            <input type="email" name="email" class="input" placeholder="E-mail">
                            <small class="red" data-si-error="email"></small>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn">Получить пароль</button>
                        </div>
                    </div>
                    <div class="login-form__content col-6 md-col-12">

                        <div class="form-group">
                            <div class="login-form__info" data-mpc-field="content">
                                Введите email указанный при регистрации и мы вышлем новый пароль.
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
