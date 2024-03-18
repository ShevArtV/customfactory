<div id="auth_17071575481732" class="showcase">
    <div class="container">
        <div class="login-form">
            {set $userData = '!ActivateUser' | snippet: []}
                            <ul class="login-form__tabs"><li><a href="registratsiya" class="{$_modx->resource.id === 22 ? 'active' : ''}">Регистрация</a></li>
<li><a href="avtorizatsiya" class="{$_modx->resource.id === 23 ? 'active' : ''}">Авторизация</a></li></ul>
            
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
                            <div class="login-form__info">Если вы забыли пароль, воспользуйтесь <a href="%7B26%20%7C%20url%7D">формой сброса пароля</a>.</div>
                        </div>

                        <div class="form-info">
                            Нажимая кнопку “Регистрация”, я принимаю условия <a href="polzovatelskoe-soglashenie">Пользовательского соглашения</a>,
                            даю согласие на обработку персональных данных в соответствии с <a href="politika-konfidenczialnosti">Политикой</a>.
                        </div>                    </div>
                </div>
                <div class="form-footer">
                    <button type="submit" class="btn">Войти</button>
                </div>
            </form>
        </div>
    </div>
</div>