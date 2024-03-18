<div id="{$id}" class="showcase">
    <div class="container">
        <div class="login-form">

            {include "file:chunks/common/ident_nav.tpl"}

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
                            <div class="login-form__info">{$content}</div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>