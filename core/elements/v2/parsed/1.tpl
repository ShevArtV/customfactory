<div id="lp_utp_17071174095817" class="showcase">
    <div class="container">
        <div class="showcase-layout">
            <div class="showcase-layout__content">
                <h1 class="showcase-title">Зарабатывайте на дизайне товаров для маркетплейсов</h1>
                <div class="showcase-text">Постоянный доход на всю жизнь для дизайнеров, художников, иллюстраторов</div>
                <img alt="Зарабатывайте на дизайне товаров для маркетплейсов" width="712" height="740" class="showcase-image" src="assets/components/migxpageconfigurator/images/fake-img.png" data-lazy="assets/project_files/img/landing/showcase.png">
                <div class="showcase-button">
                    <a href="registracziya" class="btn">
                       Попробовать сейчас                    </a>
                </div>
                <div class="showcase-advantages">
                    <ul>                    <li>Деньги — на карту</li>                    <li>По договору</li>                    <li>Каждый месяц</li>                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>{set $section = '!getStaticSection'| snippet:['section_name' => 'lp_about', 'lang_key' => '']}{if $section}{set $list_double = $section.list_double}{set $title = $section.title}{set $subtitle = $section.subtitle}{set $content = $section.content}{set $position = $section.position}{set $contacts = $section.contacts}{/if}<div id="lp_about_17069552178077" class="advantages grey-section">
    <div class="container">
        <div class="advantages-row">{foreach $list_double as $item1 index=$i last=$l}
                    <div class="advantages-item">
                <div class="advantages-item__title">{$item1.title}</div>
                <div class="advantages-item__text">{$item1.content}</div>
            </div>{/foreach}
                    </div>

        <div class="layout">
            <div class="layout-aside">
                <div class="layout-aside__title">{$title}</div>
            </div>
            <div class="layout-content">
                <div class="advantages-content">
                    <h2>{$subtitle}</h2>
                    <div class="layout-text advantages-content__text">{$content}</div>
                </div>
            </div>
        </div>

    </div>
</div><div id="lp_how_it_work_17071174096257" class="offset-top">
    <div class="container">
        <div class="layout">
            <div class="layout-aside">
                <div class="layout-aside__title red">Как это работает</div>
            </div>
            <div class="layout-content">
                <h2>Как работает Customfactory</h2>

                <div class="work-items">                    <div class="work-item">
                        <div class="work-item__aside">
                            <div class="work-item__icon">
                                <img src="assets/components/migxpageconfigurator/images/fake-img.png" alt="01
                                Вы создаёте дизайн" width="130" height="130" data-lazy="assets/project_files/img/landing/work-icon-1.svg">
                            </div>
                        </div>
                        <div class="work-item__content">
                            <div class="work-item__title"><span>01</span>
                                Вы создаёте дизайн</div>
                            <div class="work-item__text"><p>На базе простых шаблонов и загружаете макеты в сервис</p></div>
                        </div>
                    </div>                    <div class="work-item">
                        <div class="work-item__aside">
                            <div class="work-item__icon">
                                <img src="assets/components/migxpageconfigurator/images/fake-img.png" alt="02
                                Мы производим" width="130" height="130" data-lazy="assets/project_files/img/landing/work-icon-2.svg">
                            </div>
                        </div>
                        <div class="work-item__content">
                            <div class="work-item__title"><span>02</span>
                                Мы производим</div>
                            <div class="work-item__text"><p>Товары с вашим дизайном на самом технологичном и современном оборудовании</p></div>
                        </div>
                    </div>                    <div class="work-item">
                        <div class="work-item__aside">
                            <div class="work-item__icon">
                                <img src="assets/components/migxpageconfigurator/images/fake-img.png" alt="03
                                Продаём на маркетплейсах" width="130" height="130" data-lazy="assets/project_files/img/landing/work-icon-3.svg">
                            </div>
                        </div>
                        <div class="work-item__content">
                            <div class="work-item__title"><span>03</span>
                                Продаём на маркетплейсах</div>
                            <div class="work-item__text"><p>Загружаем ваши товары на WB, Ozon, ЯМ. Берём на себя рекламу, доставку, работу с клиентами</p></div>
                        </div>
                    </div>                    <div class="work-item">
                        <div class="work-item__aside">
                            <div class="work-item__icon">
                                <img src="assets/components/migxpageconfigurator/images/fake-img.png" alt="04
                                Вы получаете вознаграждение" width="130" height="130" data-lazy="assets/project_files/img/landing/work-icon-4.svg">
                            </div>
                        </div>
                        <div class="work-item__content">
                            <div class="work-item__title"><span>04</span>
                                Вы получаете вознаграждение</div>
                            <div class="work-item__text"><p>Клиент получает качественные товары с вашим дизайном, а вы деньги на карту с каждой продажи</p></div>
                        </div>
                    </div>                    </div>
            </div>
        </div>
    </div>
</div><div id="lp_products_17071174096445" class="gradient-section item-section offset">
    <div class="container">
        <div class="layout">
            <div class="layout-aside">
                <div class="layout-aside__title">Товары</div>
            </div>
            <div class="layout-content"><h2>Товары, для которых вы <br>можете делать дизайн</h2>

                <div class="layout-text" data-mpc-field="content">
                    Платим фиксированное вознаграждение. Массовые продажи на маркетплейсах
                    превращают его в солидный пассивный доход. Дизайн делаете один раз —
                    деньги получаете всю жизнь.
                </div></div>
        </div>

        <div class="offset-top">
            <div class="columns">{'pdoResources' | snippet: [
                        'parents' => '13',
'showUnpublished' => '1',
'tpl' => '@FILE chunks/pdoresources/main_categories/item.tpl',
'includeTVs' => 'img,is_hit',
'tvPrefix' => '',
'sortby' => '{ "menuindex":"ASC"}',
'limit' => '5',
]}</div>
        </div>
    </div>
</div><div id="lp_cases_17071174096669" class="offset-bottom grey-section">
    <div class="container">

        <div class="joining-bnr">
            <div class="joining-bnr__aside">
                <img src="assets/components/migxpageconfigurator/images/fake-img.png" alt="Кейсы" width="438" height="255" data-lazy="assets/project_files/img/landing/joining-bnr.jpg">
            </div>
            <div class="joining-bnr__content"><h3>Присоединяйтесь к нам</h3>
                <p>Творите и зарабатывайте, продавая товары со своим дизайном на WB, Ozon, ЯндексМаркете</p>
                <a href="registracziya" class="btn">Зарегистироваться</a></div>
        </div>

        <div class="layout">
            <div class="layout-aside">
                <div class="layout-aside__title red">Кейсы</div>
            </div>
            <div class="layout-content">
                <h2>Сколько можно заработать</h2>

                <div class="cases-items">                    
                        
                        <div class="cases-title"></div>
                        <!--cases-box-->
                        <div class="cases-item">
                            <div class="cases-item__image" style="background:url('assets/project_files/img/landing/caces/bars.png');"></div>
                            <div class="cases-item__content"><div class="cases-item__price">
                                    10 250 ₽ <span>в месяц</span>
                                </div>
                                <div class="cases-item__title">с дизайна «Снежный барс»</div>
                                <div class="cases-item__total equals">
                                    <span>125 ₽</span>
                                    выплата с продажи фотообоев из 1-й полосы
                                </div>
                                <div class="cases-item__total multiplied">
                                    <span>82 шт</span>
                                    продажи в месяц
                                </div></div>
                        </div>
                                        
                        
                        <div class="cases-title">Картины «Правила дома и кухни»</div>
                        <!--cases-box-->
                        <div class="cases-box">
                            <div class="cases-box__image" style="background:url('assets/project_files/img/landing/caces/bars.png');"></div>
                            <div class="cases-box__row"><div class="cases-box__item">
                                    <div class="cases-box__price">1 421 шт</div>
                                    <div class="cases-box__text">продано за год</div>
                                </div>
                                <div class="cases-box__item">
                                    <div class="cases-box__price">25 ₽</div>
                                    <div class="cases-box__text">
                                        выплата с продажи <br>
                                        одной картины
                                    </div>
                                </div>
                                <div class="cases-box__item">
                                    <div class="cases-box__price">2 960 ₽</div>
                                    <div class="cases-box__text">
                                        средний заработок <br>
                                        за месяц
                                    </div>
                                </div>
                                <div class="cases-box__item">
                                    <div class="cases-box__price">35 525 ₽</div>
                                    <div class="cases-box__text">
                                        заработок в год
                                    </div>
                                </div></div>
                        </div>
                                        
                        
                        <div class="cases-title"></div>
                        <!--cases-box-->
                        <div class="cases-item">
                            <div class="cases-item__image" style="background:url('assets/project_files/img/landing/caces/bars.png');"></div>
                            <div class="cases-item__content"><div class="cases-item__price">
                                    32 500 ₽ <span>в месяц</span>
                                </div>
                                <div class="cases-item__title">с дизайна фотообоев 3*2,8 м</div>
                                <div class="cases-item__total equals">
                                    <span>325 ₽</span>
                                    выплата с продажи фотообоев из 3-х полос
                                </div>
                                <div class="cases-item__total multiplied">
                                    <span>100 шт</span>
                                    продажи в месяц
                                </div></div>
                        </div>
                                        
                        
                        <div class="cases-title"></div>
                        <!--cases-box-->
                        <div class="cases-item">
                            <div class="cases-item__image" style="background:url('assets/project_files/img/landing/caces/bars.png');"></div>
                            <div class="cases-item__content"><div class="cases-item__price">
                                    8 125 ₽ <span>в месяц</span>
                                </div>
                                <div class="cases-item__title">с дизайна фотообоев «Париж»</div>
                                <div class="cases-item__total equals">
                                    <span>325 ₽</span>
                                    выплата с продажи фотообоев из 3-х полос
                                </div>
                                <div class="cases-item__total multiplied">
                                    <span>25 шт</span>
                                    продажи в месяц
                                </div></div>
                        </div>
                                        
                        
                        <div class="cases-title">Подарочная декоративная подушка 40х40 см</div>
                        <!--cases-box-->
                        <div class="cases-box">
                            <div class="cases-box__image" style="background:url('assets/project_files/img/landing/caces/bars.png');"></div>
                            <div class="cases-box__row"><div class="cases-box__item">
                                    <div class="cases-box__price">1 173 шт</div>
                                    <div class="cases-box__text">продано за год</div>
                                </div>
                                <div class="cases-box__item">
                                    <div class="cases-box__price">25 ₽</div>
                                    <div class="cases-box__text">
                                        выплата с продажи <br>
                                        одной подушки
                                    </div>
                                </div>
                                <div class="cases-box__item">
                                    <div class="cases-box__price">2 440 ₽</div>
                                    <div class="cases-box__text">
                                        средний заработок <br>
                                        за месяц
                                    </div>
                                </div>
                                <div class="cases-box__item">
                                    <div class="cases-box__price">29 325 ₽</div>
                                    <div class="cases-box__text">
                                        заработок в год
                                    </div>
                                </div></div>
                        </div>
                                        </div>
            </div>
        </div>
    </div>
</div><div id="lp_advantages_17071174096903" class="gradient-section offset">
    <div class="container">
        <div class="layout">
            <div class="layout-aside">
                <div class="layout-aside__title">Преимущества</div>
            </div>
            <div class="layout-content">
                <h2>Что отличает Customfactory</h2>
                <div>                    <div class="benefits-item">
                        
                        <div class="benefits-layout long">
                            <div class="benefits-layout__content">
                                <h4>Официальный договор</h4>
                                <span>При регистрации вы подписываете оферту на заключение лицензионного договора.</span>
                            </div>
                            <div class="benefits-layout__image">
                                <picture class="shadow radius"><source srcset="assets/project_files/img/landing/benefits-1.png" media="(min-width: 768px)">
                                    <source srcset="assets/project_files/img/landing/benefits-1-mobile.png" media="(min-width: 320px)">
                                    <img src="assets/project_files/img/landing/benefits-1.png" alt="">
                                </source></source></picture>
                            </div>
                        </div>
                    </div>                    <div class="benefits-item">
                        
                        <div class="benefits-layout ">
                            <div class="benefits-layout__content">
                                <h4>Прозрачная отчётность</h4>
                                <span>Каждый месяц отправляем на подпись акт-отчёт о продажах всех товаров с вашими дизайнами.</span>
                            </div>
                            <div class="benefits-layout__image">
                                <picture class="shadow radius"><source srcset="assets/project_files/img/landing/benefits-2.png" media="(min-width: 320px)">
                                    <img src="assets/project_files/img/landing/benefits-2.png" alt="">
                                </source></picture>
                            </div>
                        </div>
                    </div>                    <div class="benefits-item">
                        
                        <div class="benefits-layout revert">
                            <div class="benefits-layout__content">
                                <h4>Защита авторских прав</h4>
                                <span>По договору авторские права на дизайн остаются за автором в течение всей жизни и ещё 70 лет.</span>
                            </div>
                            <div class="benefits-layout__image">
                                <picture class="shadow radius"><source srcset="assets/project_files/img/landing/benefits-3.gif" media="(min-width: 320px)">
                                    <img src="assets/project_files/img/landing/benefits-3.gif" alt="">
                                </source></picture>
                            </div>
                        </div>
                    </div>                    <div class="benefits-item">
                        
                        <div class="benefits-layout ">
                            <div class="benefits-layout__content">
                                <h4>Рассказываем, что продаётся</h4>
                                <span><a href="https://t.me/customfactory" target="blank" title="Customfactory: сообщество дизайнеров">Ведём сообщество</a>,
                                в котором рассказываем, как создавать дизайны, которые будут хорошо продаваться.</span>
                            </div>
                            <div class="benefits-layout__image">
                                <picture class="shadow radius"><source srcset="assets/project_files/img/landing/benefits-4.png" media="(min-width: 768px)">
                                    <source srcset="assets/project_files/img/landing/benefits-4-mobile.png" media="(min-width: 320px)">
                                    <img src="assets/project_files/img/landing/benefits-4.png" alt="">
                                </source></source></picture>
                            </div>
                        </div>
                    </div>                    <div class="benefits-item">
                        
                        <div class="benefits-layout long">
                            <div class="benefits-layout__content">
                                <h4>Быстрая модерация</h4>
                                <span>Модерируем дизайны максимально быстро: <br>
                                в среднем 150-200 дизайнов за 8 рабочих часов.</span>
                            </div>
                            <div class="benefits-layout__image">
                                <picture class="shadow radius"><source srcset="assets/project_files/img/landing/benefits-5.png" media="(min-width: 768px)">
                                    <source srcset="assets/project_files/img/landing/benefits-5-mobile.png" media="(min-width: 320px)">
                                    <img src="assets/project_files/img/landing/benefits-5.png" alt="">
                                </source></source></picture>
                            </div>
                        </div>
                    </div>                    <div class="benefits-item">
                        
                        <div class="benefits-layout revert">
                            <div class="benefits-layout__content">
                                <h4>Живая техподержка</h4>
                                <span>Вы можете задать любой вопрос и получить быстрый ответ в
                                <a href="https://t.me/customfuctory_chat" target="blank" title="Customfactory: чат техподдержки">нашем телеграм-чате</a>.</span>
                            </div>
                            <div class="benefits-layout__image">
                                <picture class="shadow radius"><img src="assets/project_files/img/landing/benefits-6.png" alt="">
                                    <source srcset="assets/project_files/img/landing/benefits-6.png" media="(min-width: 320px)">
                                </source></picture>
                            </div>
                        </div>
                    </div>                    </div>
            </div>
        </div>
    </div>
</div><div id="lp_reviews_1707117409711" class="reviews offset grey-section">
    <div class="container">
        <div class="layout">
            <div class="layout-aside">
                <div class="layout-aside__title red">Отзывы</div>
            </div>
            <div class="layout-content">
                <h2>Что говорят дизайнеры</h2>

                <div>                    <div class="reviews-item">
                        <div class="reviews-item__aside">
                            <div class="reviews-item__avatar">
                                <img src="assets/components/migxpageconfigurator/images/fake-img.png" alt="Александр Амосов" data-lazy="assets/project_files/img/landing/disigner/photo_2022-09-02_11-32-34.jpg">
                            </div>
                            <div class="reviews-item__name">Александр Амосов</div>
                        </div>
                        <div class="reviews-item__content">
                            <div class="reviews-item__title">Кастомфактори продает мои дизайны сам.</div>
                            <div class="reviews-item__text">Я подсел на этот сервис так плотно, что уже очень и очень сложно соскочить. По-моему, это лучший сервис для ненапряжного дополнительного дохода для
                                дизайнера. Один раз
                                сделал картинку, загрузил и просто ждешь продаж. Мой первый дизайн продался через месяц. Сейчас продаются шесть дизайнов, которые приносят 40-55к в
                                месяц.</div>
                        </div>
                    </div>                    <div class="reviews-item">
                        <div class="reviews-item__aside">
                            <div class="reviews-item__avatar">
                                <img src="assets/components/migxpageconfigurator/images/fake-img.png" alt="Мария Бастракова" data-lazy="assets/project_files/img/landing/disigner/photo_2022-09-02_11-46-13.jpg">
                            </div>
                            <div class="reviews-item__name">Мария Бастракова</div>
                        </div>
                        <div class="reviews-item__content">
                            <div class="reviews-item__title">Вы создали гениальный продукт!</div>
                            <div class="reviews-item__text">Для таких загруженных дизайнеров как я customfactory— это настоящая находка. Пока я только начинаю продавать свое творчество через сервис и
                                получила первый выплаты, но планирую расширяться. Очень нравится, что можно поднять свою ЗП, не сильно отрываясь от основной работы.</div>
                        </div>
                    </div>                    <div class="reviews-item">
                        <div class="reviews-item__aside">
                            <div class="reviews-item__avatar">
                                <img src="assets/components/migxpageconfigurator/images/fake-img.png" alt="Алексей Зайцев" data-lazy="assets/project_files/img/landing/disigner/photo_2022-09-02_15-06-11.jpg">
                            </div>
                            <div class="reviews-item__name">Алексей Зайцев</div>
                        </div>
                        <div class="reviews-item__content">
                            <div class="reviews-item__title">Первые выплаты получил через 3 недели.</div>
                            <div class="reviews-item__text">Использую Customfactory уже 3 месяца после тогов как увидел рекламу в паблике «Хранитель Мокапов». Мысль о том, что нужно как-то увеличивать доход
                                давно крутилась в голове. Идея сделать дизайн один раз и продавать его всю жизнь показалась заманчивой. Заключил договор, из старых наработок
                                сделал дизайн фотообоев, одной картины и подушки. Первые выплаты получил через 3 недели. Планирую дальше конкретно погрузиться в данную тему и не
                                останавливаться на этих результатах.</div>
                        </div>
                    </div>                    <div class="reviews-item">
                        <div class="reviews-item__aside">
                            <div class="reviews-item__avatar">
                                <img src="assets/components/migxpageconfigurator/images/fake-img.png" alt="Анна Назаревич" data-lazy="assets/project_files/img/landing/disigner/photo_2022-09-02_13-06-30.jpg">
                            </div>
                            <div class="reviews-item__name">Анна Назаревич</div>
                        </div>
                        <div class="reviews-item__content">
                            <div class="reviews-item__title">Не смогла пройти мимо такой интересной идеи заработка.</div>
                            <div class="reviews-item__text">Сервис Customfuctory открыла для себя, когда делала для него дизайн страниц личного кабинета. Не смогла пройти мимо такой интересной идеи
                                заработка. С тех пор пользуюсь им, чтобы быстро превратить в товары свои иллюстрации для других проектов и продавать их на маркетплейсах.</div>
                        </div>
                    </div>                    <div class="reviews-item">
                        <div class="reviews-item__aside">
                            <div class="reviews-item__avatar">
                                <img src="assets/components/migxpageconfigurator/images/fake-img.png" alt="Ольга Грисюк" data-lazy="assets/project_files/img/landing/disigner/photo_2022-09-02_11-46-08.jpg">
                            </div>
                            <div class="reviews-item__name">Ольга Грисюк</div>
                        </div>
                        <div class="reviews-item__content">
                            <div class="reviews-item__title">Сервис радует простотой использования и наглядностью.</div>
                            <div class="reviews-item__text">Еще со времени ремонта в квартире хотела сделать свои собственные фотообои. Когда увидела рекомендацию в Телеграмме, пришла мысль попробовать
                                нарисовать на продажу. Показалось, что это должно выстрелить. Так и вышло, сейчас продаю через Customfuctory свои авторские фотообои. Сервис радует
                                простотой использования и наглядностью, всё комфортно.</div>
                        </div>
                    </div>                    <div class="reviews-item">
                        <div class="reviews-item__aside">
                            <div class="reviews-item__avatar">
                                <img src="assets/components/migxpageconfigurator/images/fake-img.png" alt="Антон Сутырин" data-lazy="assets/project_files/img/landing/disigner/photo_2022-09-13_13-16-29.jpg">
                            </div>
                            <div class="reviews-item__name">Антон Сутырин</div>
                        </div>
                        <div class="reviews-item__content">
                            <div class="reviews-item__title">Слышал о сервисе только хорошее.</div>
                            <div class="reviews-item__text">Пользуюсь сервисом всего месяц. Мои коллеги подключились еще несколько месяцев назад, и я слышал только хорошее. Знаю, что они делали дизайн
                                фотообоев, когда я подключился уже можно было дизайнить сумки, картины, подушки. Пока продаж нет, но я спокоен и уверен, что будут.</div>
                        </div>
                    </div>                    </div>
            </div>
        </div>
    </div>
</div><div id="lp_faq_17071174097316" class="gradient-section offset-bottom">
    <div class="container">

        <div class="info-bnr"><div class="info-bnr__content">
                <h3>Хотите проявить свой творческий потенциал и заработать?</h3>
            </div>
            <div class="info-bnr__aside">
                <a href="registracziya" class="btn btn--white">Начните сейчас</a>
            </div></div>

        <div class="layout">
            <div class="layout-aside">
                <div class="layout-aside__title">ЧАВО</div>
            </div>
            <div class="layout-content">
                <h2>Отвечаем на популярные вопросы</h2>

                <div class="faq-content">                    <div class="faq-item">
                        <div class="faq-item__title js-collapse-title">Вы работаете со всеми дизайнерами?</div>
                        <div class="faq-item__content"><p>Любой дизайнер может работать в сервисе, если он оформил статус самозанятого или открыл ИП.</p></div>
                    </div>                    <div class="faq-item">
                        <div class="faq-item__title js-collapse-title">Как начать работу в сервисе?</div>
                        <div class="faq-item__content"><p>Для начала работы вам необходимо <a href="https://customfactory.ru/registracziya">зарегистрироваться в личном кабинете</a>, принять оферту и
                                прислать сканы документов на проверку. </p>

                            <p><b>Документы для самозанятых:</b></p>
                            <ul>
                                <li>Справка о постановке на учёт в качестве плательщика «Налога на профессиональный доход»;</li>
                                <li>Скан основного разворота паспорта;</li>
                                <li>Скан разворота паспорта с пропиской;</li>
                                <li>Скан лицевой стороны СНИЛС.</li>
                            </ul>
                            <p><b>Документы для ИП:</b></p>
                            <ul>
                                <li>Скан свидетельства о государственной регистрации физического лица в качестве индивидуального предпринимателя;</li>
                                <li>Скан ИНН.</li>


                            </ul>
                            <p>Если у вас нет самозанятости, оформите её, это просто. Можно воспользоваться сайтом nalog.ru или приложениями популярных банков. Подробная
                                информация о самозанятости описана в ответах на частые вопросы в личном кабинете </p>

                            <p>После того как вы пришлёте документы и подпишете договор, активируется ваш личный кабинет, через который вы можете скачивать шаблоны товаров,
                                загружать дизайны и отслеживать их модерацию.</p></div>
                    </div>                    <div class="faq-item">
                        <div class="faq-item__title js-collapse-title">Сколько дизайнов я могу загрузить?</div>
                        <div class="faq-item__content"><p>Нет ограничений: можно грузить любое количество дизайнов. Все дизайны, которые прошли модерацию, попадают на маркетплейсы.</p></div>
                    </div>                    <div class="faq-item">
                        <div class="faq-item__title js-collapse-title">Как быстро начнутся продажи?</div>
                        <div class="faq-item__content"><p>Обычно проходит 4 дня до появления товара на маркетплейсах.</p>
                            <p>Дизайн, загруженный в сервис, проходит несколько стадий до старта продаж:</p>
                            <ul>
                                <li>Сначала мы оцениваем его коммерческий потенциал: будет продаваться или нет.</li>
                                <li>Затем его проверяют наши дизайнеры на соответствие техническим требованиям. Если что-то не так, дизайн вернут на доработку.</li>
                                <li>После принятия дизайна в работу, для него подготовят врисовки и этикетки, создадут карточку товара на маркетплейсе, присвоят артикул.</li>
                            </ul>
                            <p>На «раскачку» новой карточки товара может уйти 2-3 месяца. На продажи влияет очень много факторов, поэтому гарантировать, что конкретный ваш
                                товар будет иметь успех, не может никто. Продаются разные дизайны. Рекомендуем изучать рынок и загружать больше дизайнов.</p></div>
                    </div>                    <div class="faq-item">
                        <div class="faq-item__title js-collapse-title">Сколько я могу заработать?</div>
                        <div class="faq-item__content"><p>На заработок каждого дизайнера влияют несколько факторов:</p>
                            <ul>
                                <li>Количество созданных дизайнов;</li>
                                <li>Количество изделий, которые поступили в продажу;</li>
                                <li>Работа самого дизайнера по продвижению изделий со своим дизайном.</li>
                            </ul>
                            <p>То есть дизайнер, подготовивший 10 дизайнов, потенциально может заработать больше, чем создатель единственного продукта. </p>
                            <p>Значение также имеет качество и уникальность рисунка.</p>

                            <p> Каждый дизайнер вправе выбрать приемлемую модель поведения:</p>

                            <ul>
                                <li>пассивный доход, когда изделия с вашим дизайном продаются без вашего участия;</li>
                                <li>реклама и продвижение своих дизайном через соцсети, мессенджеры и т.д.</li>
                            </ul>
                            <p>Во втором случае доход будет больше.</p></div>
                    </div>                    <div class="faq-item">
                        <div class="faq-item__title js-collapse-title">Как происходят выплаты денег дизайнерам?</div>
                        <div class="faq-item__content"><p>Платим один раз в месяц: </p>
                            <ul>
                                <li>Мы получаем с маркетплейсов отчёт о продажах.</li>
                                <li>Считаем выплаты дизайнерам. Отправляем каждому персональный отчёт через сервис «Подпислон».</li>
                                <li>Отчёт нужно подписать с помощью кода, который придёт на телефон.</li>
                                <li>После этого мы переводим деньги по реквизитам карты, которые указаны при регистрации в сервисе.</li>
                            </ul>
                            <p>Ограничений по размеру выплат нет. Продали на 25 рублей — получите 25 рублей. Продали на 100 000 рублей — получите 100 000 рублей. </p></div>
                    </div>                    <div class="faq-item">
                        <div class="faq-item__title js-collapse-title">Где посмотреть ваши товары на маркетплейсах?</div>
                        <div class="faq-item__content"><p>На Wildberries и Ozon наши товары можно найти под брендами: </p>
                            <ul>
                                <li>
<a href="https://www.wildberries.ru/brands/dekorino" target="blank">Dekorino</a> — товары для уюта в доме;</li>
                                <li>
<a href="https://www.wildberries.ru/brands/youwall" target="blank">Youwall</a> — обои и фотообои;</li>
                                <li>
<a href="https://www.wildberries.ru/brands/customdesign" target="blank">Customdesign</a> — дизайнерские товары для интерьера.</li>
                            </ul></div>
                    </div>                    <div class="faq-item">
                        <div class="faq-item__title js-collapse-title">Где можно пообщаться с дизайнерами, которые уже работают в сервисе?</div>
                        <div class="faq-item__content"><p>У нас работает <a href="https://t.me/customfuctory_chat" target="blank">чат техподдержки</a> для вопросов, связанных с технической стороной
                                проекта. В него можно обращаться круглосуточно. </p>

                            <p>Также мы создали <a href="https://t.me/customfactory" target="blank">сообщество дизайнеров</a>, где регулярно пишем на актуальные темы: от
                                механики продаж до поисков вдохновения.</p>

                            <p> Аудитория чата техподдержки и сообщества и есть наши дизайнеры. Комментарии открыты: вы можете задать вопрос и получить ответ от коллег.</p></div>
                    </div>                    </div>
            </div>
        </div>
    </div>
</div>