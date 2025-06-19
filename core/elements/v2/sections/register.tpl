<div id="{$id}" class="showcase">
    <div class="container">
        <div class="login-form">

            {include "file:chunks/common/ident_nav.tpl"}

            <form class="" action="#" method="post" data-si-form="registerForm" data-si-preset="register">
                <input type="hidden" name="status" value="3">
                <input type="hidden" name="extended[offer]" value="Нет">
                <input type="hidden" name="createdon" value="##'' | date: 'd.m.Y H:i:s'}">
                <div class="login-form__layout">
                    <div class="login-form__content col-6 md-col-12">
                        <div class="form-group">
                            <input type="text" class="input" name="extended[name]" placeholder="Имя">
                            <small class="red" data-si-error="extended[name]"></small>
                        </div>
                        <div class="form-group">
                            <input type="email" name="email" class="input" placeholder="E-mail" value="">
                            <small class="red" data-si-error="email"></small>
                        </div>
                        <div class="form-group">
                            <input type="tel" name="phone" class="input" placeholder="+7(9" value="">
                            <small class="red" data-si-error="phone"></small>
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
                    <button type="submit" class="btn">Регистрация</button>
                </div>
            </form>
        </div>
    </div>
</div>