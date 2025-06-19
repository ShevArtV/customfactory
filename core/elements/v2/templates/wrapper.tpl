<!DOCTYPE html>
<html lang="ru">
<head>
    {* /usr/local/php/php-7.4/bin/php /home/host1860015/art-sites.ru/htdocs/customfactory/core/components/migxpageconfigurator/console/slice_tpl.php web wrapper.tpl *}
    {* php7.4 -d display_errors -d error_reporting=E_ALL ~/www/core/components/migxpageconfigurator/console/slice_tpl.php web wrapper.tpl *}
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
    {set $cp_id = $_modx->config.mpc_contacts_page_id}

    {* метрики *}
    {set $metrics = $_modx->config.metrics | replace: '{' : '{ '}
    {set $ym_id = $_modx->config.ym_id}

    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <meta http-equiv="Cache-Control" content="private, no-store, no-cache"/>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="description" content="{$description}">
    
    <meta name="language" content="ru" />
    <meta name="keywords" content="{$introtext}" />
    <meta name="description" content="{$description}" />
    <meta property="og:site_name" content="{$site_name}" />
    <meta property="og:url" content="{$site_url}" />
    <meta property="og:title" content="{$pagetitle}" />
    <meta property="og:description" content="{$description}" />
    <meta property="og:image" content="https://customfactory.ru/assets/project_files/v2/img/landing/logotype.svg" />
    <meta property="og:type" content="website" />
    <meta property="og:locale" content="ru_RU" />
    
    <meta name="twitter:site" content="{$site_name}">
    <meta name="twitter:title" content="{$pagetitle}">
    <meta name="twitter:image" content="https://customfactory.ru/assets/project_files/v2/img/landing/logotype.svg">
    <meta name="twitter:description" content="{$description}">
    
    <meta name="robots" content="MAX-SNIPPET:-1, index, follow">
    
    <link rel="canonical" href="{$site_url}">
    
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

    <link rel="stylesheet" href="assets/project_files/v2/css/landing/style.css?v={''|date: 'dmYHis'}">
    <link rel="stylesheet" href="assets/project_files/v2/css/landing/jquery.fancybox.css">

    <script src="assets/project_files/v2/js/landing/jquery-3.6.0.js"></script>
    <script src="assets/project_files/v2/js/landing/jquery.maskedinput.min.js"></script>
    <script src="assets/project_files/v2/js/landing/lozad.js"></script>
    <script src="assets/project_files/v2/js/landing/splide.min.js"></script>
    <script src="assets/project_files/v2/js/landing/fancybox.min.js"></script>
    <script src="assets/project_files/v2/js/landing/micromodal.js"></script>
    <script src="assets/project_files/v2/js/landing/script.js"></script>
    <script src="//code.jivo.ru/widget/Dc6HgKuRAU" async></script>


    {$metrics?:''}
</head>

<body>
<div data-mpc-section="wrapper" class="wrapper">
    <!-- header -->
    <header class="header index">
        <div class="container">
            <div class="header-content">
                <a href="" class="logotype">
                    <img src="{$logo}" alt="" width="213" height="48">
                </a>
                <ul class="header-auth">
                    {if $_modx->user.id > 0}
                        <li>
                            <form data-si-form data-si-preset="logout">
                                <button type="submit" class="header-auth__item">
                                    Выход
                                </button>
                            </form>
                        </li>
                        <li>
                            {if $_modx->user.id | ismember: "Designers"}
                                {set $dashboardUrl = (28 | url)}
                                <a href="{$dashboardUrl}" class="header-auth__item">{28 | resource: 'menutitle'}</a>
                            {else}
                                {set $dashboardUrl = (54750 | url)}
                                <a href="{$dashboardUrl}" class="header-auth__item">{54750 | resource: 'menutitle'}</a>
                            {/if}
                        </li>
                    {else}
                        {set $authUrl = (23 | url)}
                        {set $regUrl = (22 | url)}
                        <li>
                            <svg width="24" height="25" viewBox="0 0 24 25" fill="none">
                                <path fill-rule="evenodd" clip-rule="evenodd"
                                      d="M5.84844 16.4987C7.63895 15.5237 9.8007 15.01 12 15.01C14.1993 15.01 16.3611 15.5237 18.1516 16.4987C19.9414 17.4734 21.3023 18.8808 21.9329 20.5508C22.1458 21.1147 21.8353 21.7351 21.2394 21.9365C20.6435 22.138 19.9878 21.8442 19.7749 21.2803C19.361 20.184 18.4204 19.1469 17.0085 18.3781C15.5974 17.6096 13.8363 17.1783 12 17.1783C10.1637 17.1783 8.40261 17.6096 6.99146 18.3781C5.57964 19.1469 4.63901 20.184 4.22508 21.2803C4.01218 21.8442 3.35651 22.138 2.76061 21.9365C2.1647 21.7351 1.85421 21.1147 2.06711 20.5508C2.69767 18.8807 4.0586 17.4734 5.84844 16.4987Z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd"
                                      d="M11.9999 4.16833C10.1015 4.16833 8.56256 5.62452 8.56256 7.42083C8.56256 9.21713 10.1015 10.6733 11.9999 10.6733C13.8983 10.6733 15.4372 9.21713 15.4372 7.42083C15.4372 5.62452 13.8983 4.16833 11.9999 4.16833ZM6.271 7.42083C6.271 4.42699 8.83591 2 11.9999 2C15.1639 2 17.7288 4.42699 17.7288 7.42083C17.7288 10.4147 15.1639 12.8417 11.9999 12.8417C8.83591 12.8417 6.271 10.4147 6.271 7.42083Z"/>
                            </svg>
                            <a href="{$authUrl}" class="header-auth__item">{23 | resource: 'menutitle'}</a>
                        </li>
                        <li>
                            <svg width="24" height="25" viewBox="0 0 24 25" fill="none">
                                <path fill-rule="evenodd" clip-rule="evenodd"
                                      d="M10.7366 3.97531C9.07786 3.97531 7.73321 5.30187 7.73321 6.93827C7.73321 8.57467 9.07786 9.90123 10.7366 9.90123C12.3953 9.90123 13.74 8.57467 13.74 6.93827C13.74 5.30187 12.3953 3.97531 10.7366 3.97531ZM5.73096 6.93827C5.73096 4.21094 7.97205 2 10.7366 2C13.5011 2 15.7422 4.21094 15.7422 6.93827C15.7422 9.6656 13.5011 11.8765 10.7366 11.8765C7.97205 11.8765 5.73096 9.6656 5.73096 6.93827Z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd"
                                      d="M11.9973 13.9072C11.5807 13.8623 11.1593 13.8396 10.7364 13.8396C8.81731 13.8396 6.93051 14.3069 5.36707 15.1946C3.80462 16.0816 2.61293 17.3645 2.06003 18.8913C1.87197 19.4106 2.14049 19.984 2.65977 20.172C3.17906 20.3601 3.75246 20.0916 3.94052 19.5723C4.30024 18.5789 5.11954 17.635 6.35453 16.9338C7.36954 16.3575 8.59209 15.989 9.88836 15.8763C10.2065 14.9096 11.0028 14.16 11.9973 13.9072Z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd"
                                      d="M16.7431 11.6296C17.4342 11.6296 17.9945 12.1824 17.9945 12.8642L17.9945 20.7654C17.9945 21.4473 17.4342 22 16.7431 22C16.052 22 15.4917 21.4473 15.4917 20.7654L15.4917 12.8642C15.4917 12.1824 16.052 11.6296 16.7431 11.6296Z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd"
                                      d="M21.999 16.8149C21.999 17.4967 21.4388 18.0495 20.7476 18.0495L12.7386 18.0495C12.0475 18.0495 11.4872 17.4967 11.4872 16.8149C11.4872 16.1331 12.0475 15.5803 12.7386 15.5803L20.7476 15.5803C21.4388 15.5803 21.999 16.1331 21.999 16.8149Z"/>
                            </svg>
                            <a href="{$regUrl}" class="header-auth__item active">{22 | resource: 'menutitle'}</a>
                        </li>
                    {/if}
                </ul>
            </div>
        </div>
    </header>

    <!-- wrap -->
    <main class="wrap" data-mpc-content>

        <!--CONTENT-->
        {block 'content'}{/block}
        <!--CONTENT-->

    </main>

    <!-- footer -->
    <footer class="footer">
        <div class="container">

            {if !($rid in list [22,23,26])}
                <div class="footer-top">
                    <div class="columns">
                        <div class="column col-6 md-col-12">
                            <h3>{$cp_id | resource: 'longtitle'}</h3>
                            {$cp_id | resource: 'introtext'}
                            <ul class="footer-contact" data-mpc-snippet="pdoResources|footer_contacts" data-mpc-symbol="{ ">
                                <li data-mpc-chunk="pdoresources/footer_contacts/item.tpl">
                                    <div class="footer-contact__icon">
                                        {$introtext}
                                    </div>
                                    <a href="{$content}">{$description}</a>
                                </li>
                            </ul>
                        </div>
                        <div class="column col-6 md-col-12">
                            <form data-si-form="footerForm" class="form" data-si-preset="base_form">
                                <div class="form-group">
                                    <input type="email" name="email" class="input" placeholder="E-mail">
                                    <small class="red error_email" data-si-error="email"></small>
                                </div>
                                <div class="form-group">
                                    <input type="text" name="name" class="input" placeholder="Имя">
                                    <small class="red error_name" data-si-error="name"></small>
                                </div>
                                <div class="form-group">
                                    <textarea class="input textarea" name="message" placeholder="Ваше сообщение"></textarea>
                                    <small class="red error_message" data-si-error="message"></small>
                                </div>
                                <div class="form-group">
                                    <div class="form-info">Нажимая на кнопку, вы соглашаетесь на обработку персональных данных</div>
                                </div>
                                <button type="submit" class="btn">Оставить заявку</button>
                            </form>
                        </div>
                    </div>
                </div>
            {/if}

            <div class="footer-bottom">
                <div class="footer-logo">
                    <img src="{$logo}" alt="" width="213" height="48">
                </div>

                <ul class="footer-bottom__list">
                    <li>© {'' | date: 'Y'} Все права защищены</li>
                    <div data-mpc-unwrap="1" data-mpc-snippet="pdoResources|legal_info" data-mpc-symbol="{ ">
                        <li data-mpc-chunk="pdoresources/legal_info/item.tpl"><a href="{$uri}">{$menutitle}</a></li>
                    </div>
                </ul>
            </div>

        </div>

        {if $template === 9}
            <script type="module" src="assets/project_files/v2/js/lk/scripts.js?v={'' | date: 'dmYHis'}"></script>
        {/if}

        <!-- SQL: [^qt^] ([^q^]), PHP: [^p^], MEM: [^m^], ALL: [^t^] ([^s^]) -->
    </footer>
</div>
</body>
</html>
