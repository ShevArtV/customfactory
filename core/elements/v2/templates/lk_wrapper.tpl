<!DOCTYPE html>
<html lang="ru">
<head>
    {* /usr/local/php/php-7.4/bin/php /home/host1860015/art-sites.ru/htdocs/customfactory/core/components/migxpageconfigurator/console/slice_tpl.php web lk_wrapper.tpl *}
    {* общие поля сайта *}
    {set $site_url = $_modx->config.site_url}
    {set $site_name = $_modx->config.site_name}

    {* основные поля ресурса *}
    {set $rid = $_modx->resource.id}
    {set $pagetitle = $rid | resource: 'pagetitle'}
    {set $longtitle = $rid | resource: 'longtitle'}
    {set $menutitle = $rid | resource: 'menutitle'}
    {set $description = $rid | resource: 'description'}
    {set $introtext = $rid | resource: 'introtext'}
    {set $content = $rid | resource: 'content'}
    {set $template = $rid | resource: 'template'}

    {* символика *}
    {set $logo = $_modx->config.logo}
    {set $logo_alt = $_modx->config.logo_alt}
    {set $logo_mini = $_modx->config.logo_mini}
    {set $favicon = $_modx->config.favicon}
    {set $favicon_apple = $_modx->config.favicon_apple}

    {*контакты *}
    {set $cp_id = $_modx->config.contacts_page_id}
    {set $contacts = 'getContacts' | snippet:[]}

    {* метрики *}
    {set $metrics = $_modx->config.metrics | replace: '{' : '{ '}
    {set $ym_id = $_modx->config.ym_id}

    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="description" content="{$description}">
    {if $ym_id}
        <meta name="ym_id" content="{$ym_id}">
    {/if}
    <base href="{$site_url}">
    <title>{$pagetitle}</title>

    <!-- favicons -->
    {if $favicon}
        <link rel="icon" href="{$favicon}">
    {/if}
    {if $favicon_apple}
        <link rel="apple-touch-icon" sizes="180x180" href="{$favicon_apple}">
    {/if}

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Raleway:wght@400;500;600;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="assets/project_files/v2/css/lk/style.css?v={'' | date: 'dmYHis'}">
    <link rel="stylesheet" href="assets/project_files/v2/css/lk/select.css?v={'' | date: 'dmYHis'}">


    <script src="assets/project_files/v2/js/lk/jquery-3.6.0.js"></script>


   {$_modx->setPlaceholder('statuses', $_modx->runSnippet('@FILE snippets/base/snippet.getstatuses.php', []))}
</head>

<body>
<div data-mpc-section="lk_wrapper" class="wrapper">

    <!--sidebar-->
    <div class="sidebar sidebar-hidden" id="sidebar">
        <div class="sidebar-close lg-visible" data-toggle="#sidebar"></div>

        <div class="sidebar-wrap">
            <div class="sidebar-label" data-toggle="#sidebar"></div>

            <div class="sidebar-header">
                <a href="" class="logotype">
                    <img src="assets/project_files/v2/img/lk/logo-img.svg" alt="" width="35" height="35" class="logotype-img">
                    <img src="assets/project_files/v2/img/lk/logo-text.svg" alt="" width="136" height="13" class="logotype-text">
                </a>
            </div>

            <div class="sidebar-content scrollbar">
                <ul class="sidebar-menu lg-visible">
                    <li>
                        <div class="sidebar-menu__link">{$_modx->user.fullname}</div>
                    </li>
                </ul>
                <ul class="sidebar-menu">
                    <li>
                        <a href="" class="sidebar-menu__link" rel="Мой кабинет">
                            <img src="assets/project_files/v2/img/lk/icon-home.svg" alt="" width="35" height="35">
                            Мой кабинет
                        </a>
                        <ul>
                            <li><a href="">Мой профиль</a></li>
                            <li><a href="">Шаблоны и техтребования</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="" class="sidebar-menu__link" rel="Товары">
                            <img src="assets/project_files/v2/img/lk/icon-basket.svg" alt="" width="35" height="35">
                            Товары
                        </a>
                        <ul>
                            <li><a href="">Загрузить новый</a></li>
                            <li><a href="">Мои товары</a></li>
                            <li><a href="">Статистика продаж</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="" class="sidebar-menu__link" rel="Юридическая информация">
                            <img src="assets/project_files/v2/img/lk/icon-file.svg" alt="" width="35" height="35">
                            Юридическая информация
                        </a>
                        <ul>
                            <li><a href="">Оферта</a></li>
                            <li><a href="">История оферт</a></li>
                            <li><a href="">Условия использования</a></li>
                            <li><a href="">Персональные данные</a></li>
                            <li><a href="">Правила допустимого содержания</a></li>
                        </ul>
                    </li>
                    <li>
                        <a href="" class="sidebar-menu__link" rel="Помощь">
                            <img src="assets/project_files/v2/img/lk/icon-question.svg" alt="" width="35" height="35">
                            Помощь
                        </a>
                        <ul>
                            <li><a href="">Частые вопросы</a></li>
                            <li><a href="">Написать в поддержку</a></li>
                            <li><a href="">Сообщество дизайнеров</a></li>
                        </ul>
                    </li>
                </ul>

                <div class="sidebar-footer">
                    <ul class="sidebar-menu">
                        <li>
                            <a href="" class="sidebar-menu__link" rel="Выход">
                                <img src="assets/project_files/v2/img/lk/icon-exit.svg" alt="" width="35" height="35">
                                Выход
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

        </div>
    </div>

    <!-- header -->
    <header class="header">
        <div class="container">

            <div class="header-content">

                <a href="" class="logotype lg-visible">
                    <img src="assets/project_files/v2/img/lk/logo-img.svg" alt="" width="35" height="35" class="logotype-img">
                    <img src="assets/project_files/v2/img/lk/logo-text.svg" alt="" width="136" height="13" class="logotype-text">
                </a>

                <div class="burger lg-visible js-sidebar-toggle"></div>

                <div class="header-lk lg-hidden">

                    <div class="header-user">
                        <div class="header-user__name" data-popup-link="lk-user">Евгений</div>
                        <div class="popup-menu" data-popup="lk-user">
                            <ul>
                                <li><a href="">Профиль</a></li>
                                <li><a href="">Выход</a></li>
                            </ul>
                        </div>
                    </div>
                </div>

            </div>

        </div>
    </header>

    <!-- wrap -->
    <main class="wrap">
        <div class="container">

            <h1>Добро пожаловать, {$_modx->user.fullname}!</h1>

            <div data-mpc-content>
                <!--CONTENT-->
                {block 'content'}{/block}
                <!--CONTENT-->
            </div>
        </div>
    </main>

    <!-- footer -->
    <footer class="footer">
        <div class="container">

            <div class="footer-top">

                <div class="footer-top__aside">
                    <div class="footer-logotype">
                        <img src="assets/project_files/v2/img/lk/logo-footer.svg" alt="" width="176" height="35">
                    </div>
                    <div class="footer-copyright">
                        Создание и продажа дизайнерских товаров через маркетплейсы
                    </div>
                </div>

                <div class="footer-top__content">

                    <ul class="footer-menu">
                        <li><a href="">Загрузить новый</a></li>
                        <li><a href="">Мои товары</a></li>
                        <li><a href="">Статистика продаж</a></li>
                        <li><a href="">Сообщество</a></li>
                        <li><a href="">Частые вопросы</a></li>
                    </ul>

                    <div class="social">
                        <a href="" class="social-item">
                            <img src="assets/project_files/v2/img/lk/icon-tg.svg" alt="" width="22" height="18">
                        </a>
                    </div>

                </div>

            </div>

            <div class="footer-bottom">
                <div class="footer-copyright">
                    © 2022 Все права защищены. 121 121 Россия, Иваново, пр-т Ленина, дом 21, литер Л
                </div>
            </div>

        </div>
        <!-- SQL: [^qt^] ([^q^]), PHP: [^p^], MEM: [^m^], ALL: [^t^] ([^s^]) -->
    </footer>

    <script type="module" src="assets/project_files/v2/js/lk/scripts.js?v={'' | date: 'dmYHis'}"></script>
</div>
</body>
</html>
