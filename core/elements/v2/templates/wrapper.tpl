<!DOCTYPE html>
<html lang="ru">
<head>
    {* /usr/local/php/php-7.4/bin/php -d display_errors -d error_reporting=E_ALL /home/host1860015/art-sites.ru/htdocs/customfactory/core/components/migxpageconfigurator/console/slice_tpl.php web wrapper.tpl *}
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
    <meta http-equiv="Cache-Control" content="private, no-store, no-cache" />
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

    <link rel="stylesheet" href="assets/project_files/v2/css/landing/style.css?v={''|date: 'dmYHis'}">
    <link rel="stylesheet" href="assets/project_files/v2/css/landing/jquery.fancybox.css">

    <script src="assets/project_files/v2/js/landing/jquery-3.6.0.js"></script>
    <script src="assets/project_files/v2/js/landing/jquery.maskedinput.min.js"></script>
    <script src="assets/project_files/v2/js/landing/lozad.js"></script>
    <script src="assets/project_files/v2/js/landing/splide.min.js"></script>
    <script src="assets/project_files/v2/js/landing/fancybox.min.js"></script>
    <script src="assets/project_files/v2/js/landing/micromodal.js"></script>
    <script src="assets/project_files/v2/js/landing/script.js"></script>

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
                            <form>
                                <button type="submit" class="header-auth__item">
                                    {$btn_text?:'Выход'}
                                </button>
                            </form>
                        </li>
                        <li>
                            {set $dashboardUrl = (46 | url)}
                            <a href="{$dashboardUrl}" class="header-auth__item">{32 | resource: 'menutitle'}</a>
                        </li>
                    {else}
                        {set $authUrl = (29 | url)}
                        {set $regUrl = (30 | url)}
                        <li>
                            <svg width="24" height="25" viewBox="0 0 24 25" fill="none">
                                <path fill-rule="evenodd" clip-rule="evenodd"
                                      d="M5.84844 16.4987C7.63895 15.5237 9.8007 15.01 12 15.01C14.1993 15.01 16.3611 15.5237 18.1516 16.4987C19.9414 17.4734 21.3023 18.8808 21.9329 20.5508C22.1458 21.1147 21.8353 21.7351 21.2394 21.9365C20.6435 22.138 19.9878 21.8442 19.7749 21.2803C19.361 20.184 18.4204 19.1469 17.0085 18.3781C15.5974 17.6096 13.8363 17.1783 12 17.1783C10.1637 17.1783 8.40261 17.6096 6.99146 18.3781C5.57964 19.1469 4.63901 20.184 4.22508 21.2803C4.01218 21.8442 3.35651 22.138 2.76061 21.9365C2.1647 21.7351 1.85421 21.1147 2.06711 20.5508C2.69767 18.8807 4.0586 17.4734 5.84844 16.4987Z"/>
                                <path fill-rule="evenodd" clip-rule="evenodd"
                                      d="M11.9999 4.16833C10.1015 4.16833 8.56256 5.62452 8.56256 7.42083C8.56256 9.21713 10.1015 10.6733 11.9999 10.6733C13.8983 10.6733 15.4372 9.21713 15.4372 7.42083C15.4372 5.62452 13.8983 4.16833 11.9999 4.16833ZM6.271 7.42083C6.271 4.42699 8.83591 2 11.9999 2C15.1639 2 17.7288 4.42699 17.7288 7.42083C17.7288 10.4147 15.1639 12.8417 11.9999 12.8417C8.83591 12.8417 6.271 10.4147 6.271 7.42083Z"/>
                            </svg>
                            <a href="{$authUrl}" class="header-auth__item">{29 | resource: 'menutitle'}</a>
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
                            <a href="{$regUrl}" class="header-auth__item active">{30 | resource: 'menutitle'}</a>
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

            {if !($rid in list [29,30,31])}
                <div class="footer-top">
                    <div class="columns">
                        <div class="column col-6 md-col-12">
                            <h3>{$cp_id | resource: 'longtitle'}</h3>
                            {$cp_id | resource: 'introtext'}
                            <ul class="footer-contact">
                                <li>
                                    <div class="footer-contact__icon">
                                        <svg width="22" height="19" viewBox="0 0 22 19">
                                            <path d="M20.7116 0.0393226C20.1976 0.178402 19.7093 0.423445 19.2146 0.608883C13.2585 2.97323 7.30243 5.34419 1.34635 7.70853C0.922297 7.88073 0.459691 8.03967 0.151285 8.39731C-0.00291704 8.5695 -0.0607453 8.85428 0.080607 9.05296C0.27336 9.3245 0.601041 9.43046 0.896596 9.53643C2.39365 10.0133 3.89069 10.4901 5.38132 10.9802C5.57407 11.0398 5.79895 11.1259 5.98528 10.9802C9.78894 8.51652 13.5862 6.03959 17.3963 3.5759C17.6276 3.41033 17.9167 3.40371 18.1866 3.45007C18.1095 3.60239 18.0324 3.76134 17.9039 3.88055C14.9804 6.58928 12.0763 9.30463 9.15928 12.0134C8.97938 12.1922 8.76735 12.3445 8.63885 12.5763C8.56175 12.9604 8.5746 13.3578 8.5489 13.7485C8.46537 15.1128 8.33687 16.4705 8.28547 17.8348C8.95368 17.8348 9.35846 17.2454 9.8018 16.8149C10.4443 16.1857 11.0675 15.5367 11.7293 14.9274C13.3999 16.1195 15.0126 17.4109 16.6574 18.6428C17.0365 18.9077 17.544 19.1329 17.9938 18.9077C18.4114 18.6958 18.5528 18.1924 18.6427 17.762C19.6965 12.6359 20.7502 7.50985 21.8103 2.3838C21.9324 1.76788 22.1509 1.0791 21.8424 0.489674C21.6304 0.0724368 21.1228 -0.079888 20.7116 0.0393226Z"/>
                                        </svg>
                                    </div>
                                    <a href="{$contacts['socials'][0]['value']}">{$contacts['socials'][0]['caption']}</a>
                                </li>
                                <li>
                                    <div class="footer-contact__icon">
                                        <svg width="24" height="18" viewBox="0 0 24 18">
                                            <path d="M2.36108 0.0596761C2.78261 -0.00385002 3.20414 0.0279122 3.63186 0.015207C9.10552 -0.0038508 14.5854 -0.00385022 20.059 0.008855C20.6231 -0.0102028 21.1872 0.0596753 21.7513 0.0787331C22.5944 0.21849 23.3383 0.828341 23.7164 1.60971C23.9272 2.04804 23.9706 2.54355 23.983 3.02634C24.0077 6.41228 24.0016 9.80457 23.9892 13.1905C23.9644 13.8766 24.0573 14.6008 23.7908 15.2551C23.4312 16.1191 22.6502 16.8115 21.7327 16.9703C20.9083 16.9957 20.0838 16.964 19.2532 16.9957C18.906 17.0338 18.5527 17.0275 18.1994 17.0275C13.8601 17.0338 9.52085 17.0338 5.1816 17.0275C4.35714 16.9576 3.52648 16.9894 2.70202 16.983C1.92716 17.0402 1.17709 16.6209 0.687371 16.0238C0.216252 15.5283 0.0240855 14.8295 0.0240855 14.1561C-0.00690914 10.7066 -0.00690905 7.25083 0.0178867 3.80136C0.0302845 3.01999 -0.031705 2.16874 0.377424 1.46995C0.81135 0.745758 1.51183 0.129555 2.36108 0.0596761ZM1.41265 3.15975C1.6978 3.50279 2.08833 3.72513 2.41067 4.01735C4.16497 5.42128 5.91927 6.8252 7.67357 8.21642C7.75415 8.27995 7.86573 8.38794 7.78515 8.49594C7.52479 8.83898 7.19625 9.11214 6.9111 9.43613C5.82009 10.5415 4.77867 11.6977 3.69385 12.8094C3.17934 13.3557 2.63384 13.8702 2.15032 14.4547C2.38588 14.3022 2.62764 14.1561 2.8508 13.9782C3.89222 13.2032 4.95224 12.46 5.96886 11.6595C6.99788 10.9163 8.02071 10.1603 9.04353 9.41071C9.14891 9.29637 9.28529 9.3853 9.38447 9.45518C10.2213 10.0015 11.0334 10.5859 11.8888 11.1005C11.988 11.1831 12.0996 11.1069 12.1926 11.056C13.0232 10.5415 13.8229 9.96339 14.6474 9.43613C14.7279 9.39801 14.8271 9.30907 14.9077 9.39166C15.3726 9.71564 15.8314 10.0523 16.2839 10.4017C16.9038 10.8401 17.5175 11.2974 18.1312 11.7485C18.7573 12.263 19.4267 12.7141 20.0838 13.1715C20.5178 13.4764 20.9145 13.8512 21.398 14.0735C21.2678 13.8448 21.0881 13.6543 20.9021 13.47C20.1954 12.7712 19.5445 12.0216 18.8502 11.3165C18.0258 10.4652 17.2385 9.57588 16.4017 8.74369C16.3211 8.62934 16.1289 8.515 16.1971 8.34983C16.3459 8.18466 16.5318 8.06396 16.7054 7.9242C18.4783 6.50757 20.2636 5.09729 22.0303 3.66796C22.2287 3.51549 22.427 3.36303 22.582 3.17245C22.2349 3.24869 21.9435 3.45197 21.6398 3.62984C20.0342 4.50015 18.4411 5.38951 16.848 6.27888C16.2281 6.59016 15.6516 6.96496 15.0317 7.27624C14.201 7.74633 13.358 8.18466 12.5273 8.66111C12.3104 8.7691 12.0748 8.93427 11.833 8.83898C11.1512 8.515 10.5189 8.10208 9.84319 7.77174C8.68399 7.11107 7.5062 6.49487 6.34699 5.82784C5.07621 5.14811 3.82403 4.41757 2.55325 3.74419C2.18131 3.5282 1.83417 3.24868 1.41265 3.15975Z"/>
                                        </svg>
                                    </div>
                                    <a href="mailto:{$contacts['emails'][0]['value']}">{$contacts['emails'][0]['value']}</a>
                                </li>
                            </ul>
                        </div>
                        <div class="column col-6 md-col-12">
                            <form action="" class="form" method="post" data-ymgoal="{$ym_goal}">
                                <div class="form-group">
                                    <input type="email" name="email" class="input" placeholder="E-mail">
                                    <small class="red error_email"></small>
                                </div>
                                <div class="form-group">
                                    <input type="text" name="name" class="input" placeholder="Имя">
                                    <small class="red error_name"></small>
                                </div>
                                <div class="form-group">
                                    <textarea class="input textarea" name="message" placeholder="Ваше сообщение"></textarea>
                                    <small class="red error_message"></small>
                                </div>
                                <div class="form-group">
                                    <div class="form-info">Нажимая на кнопку, вы соглашаетесь на обработку персональных данных</div>
                                </div>
                                <button type="submit" class="btn">{$btn_text?:'Оставить заявку'}</button>
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
                    <li><a href="{6 | url}">{6 | resource: 'pagetitle'}</a></li>
                    <li><a href="{28 | url}">{28 | resource: 'pagetitle'}</a></li>
                </ul>
            </div>

        </div>
        <!-- SQL: [^qt^] ([^q^]), PHP: [^p^], MEM: [^m^], ALL: [^t^] ([^s^]) -->
    </footer>
</div>

<div id="modal-1" aria-hidden="true" class="modal">
    <div data-micromodal-close class="modal-overlay">
        <div class="modal-main">
            <div class="modal-title">Modal Title</div>
            <button data-micromodal-close>X</button>
            <div class="modal-content">
                <button data-micromodal-trigger="modal-1">Нажать нежно</button>
                Modal Content
            </div>
        </div>
    </div>
</div>

<div class="symbols">
    <svg>

    </svg>
</div>

</body>
</html>
