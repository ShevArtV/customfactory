<div id="{$id}" class="showcase">
    <div class="container">
        <div class="login-form">
            ##set $userData = '!ActivateUser' | snippet: []}
            {include "file:chunks/common/ident_nav.tpl"}

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
                            <div class="login-form__info">{$content}</div>
                        </div>

                        {include "file:chunks/common/form_links.tpl"}
                    </div>
                </div>
                <div class="form-footer">
                    <button type="submit" class="btn">Войти</button>
                </div>
            </form>
        </div>
    </div>
</div>