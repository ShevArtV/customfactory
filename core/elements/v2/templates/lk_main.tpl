<!--##{"templatename":"Мой кабинет","pagetitle":"Страница Мой кабинет","icon":"icon-qrcode","extends":"12"}##-->

<!-- /usr/local/php/php-7.4/bin/php /home/host1860015/art-sites.ru/htdocs/customfactory/core/components/migxpageconfigurator/console/mgr_tpl.php web lk_main.tpl -->

<!--Вопросы-ответы-->
<div id="{$id}" data-mpc-section="user_progress" data-mpc-name="Прогресс пользователя">
    ##if !('user_allow_add' | placeholder)}
    <div class="page-layout offset-top offset-top--small">
        <div class="page-layout__content container-small">

            <h2 data-mpc-field="title">Ваши следующие шаги</h2>

            <div class="page" data-mpc-field="subtitle">
                Закончите регистрацию до конца, создавайте товары, получайте вознаграждение и зарабатывайте вместе с Customfactory
            </div>

            <div class="step-header">
                ##'user_total' | placeholder | declension : 'шаг|шага|шагов' : true} из 5 пройдено
                ##set $progress = $_modx->getPlaceholder('user_progress')}
                ##set $steps = $_modx->getPlaceholder('user_steps')}
                <div class="step-loading">
                    <span style="width: ##$progress}%;">##$progress}%</span>
                </div>

            </div>

            <ul class="step-list" data-mpc-field="list_triple">
                <li data-mpc-item class="##$steps.{$item1.subtitle} ? 'active' : ''}">
                    <span data-mpc-field-1="subtitle" data-mpc-remove="">reg</span>
                    <div class="step-list__title" data-mpc-field-1="title">Зарегистируйтесь в Customfactory</div>
                    <div class="step-list__text" data-mpc-field-1="content"></div>
                </li>
                <li data-mpc-item class="active">
                    <span data-mpc-field-1="subtitle" data-mpc-remove="">email</span>
                    <div class="step-list__title" data-mpc-field-1="title">Подтвердите адрес электронной почты</div>
                </li>
                <li data-mpc-item>
                    <span data-mpc-field-1="subtitle" data-mpc-remove="">offer</span>
                    <div class="step-list__title" data-mpc-field-1="title">Подпишите оферту</div>
                    <div class="step-list__text" data-mpc-field-1="content">
                        Без <a href="{51976 | url}">подписания договора</a> вы не сможете создавать
                        и продавать товары
                    </div>
                </li>
                <li data-mpc-item>
                    <span data-mpc-field-1="subtitle" data-mpc-remove="">status</span>
                    <div class="step-list__title" data-mpc-field-1="title">Заполните личные данные</div>
                    <div class="step-list__text" data-mpc-field-1="content">
                        <a href="{51979 | url}">Укажите контакты</a>, добавьте карту, телефон и адрес.
                        Загрузите сканы паспорта и документ о регистрации в качестве самозанятого
                    </div>
                </li>
                <li data-mpc-item>
                    <span data-mpc-field-1="subtitle" data-mpc-remove="">prods</span>
                    <div class="step-list__title" data-mpc-field-1="title">Создайте свой товар</div>
                    <div class="step-list__text" data-mpc-field-1="content">
                        На основе <a href="{13 | url}">простых шаблонов</a>. Создание товаров доступно только
                        после полной регистрации и проверки ваших данных модератором
                    </div>
                </li>
            </ul>

            <div class="page" data-mpc-field="content">
                Прочитайте <a href="{54743 | url}">Условия использования</a> и <a href="{54746 | url}">Правила допустимого содержания</a>
            </div>
        </div>


        <div class="page-layout__aside" data-mpc-snippet="pdoResources|help_aside">
            <a href="{$id == 51972 ? $uri : $content}" target="{($class_key == 'modWebLink' ? '_blank' : '')}" class="block-link"
               data-mpc-chunk="pdoresources/help_aside/item.tpl">
                <div class="block-link__title">{$menutitle}</div>
                <div class="block-link__image">
                    <img src="{$img}" alt="{$pagetitle}" width="92" height="93">
                </div>
                <div class="block-link__text">
                    {$longtitle}
                </div>
            </a>
        </div>
    </div>
    ##/if}
</div>

<div id="{$id}" data-mpc-section="user_dashboard" data-mpc-name="Пользовательская панель управления">
    ##if ('user_allow_add' | placeholder)}
    <div class="offset-top offset-top--small container-medium">
        <div class="input-group">
            <a href="13" class="btn" data-mpc-field="target">
                <span data-mpc-field="btn_text">Загрузить товар</span>
            </a>
        </div>
        <div class="page" data-mpc-field="content">
            Загрузите файлы с дизайном товара, который вы сделали, в сервис
        </div>
    </div>

    <div data-mpc-snippet="msProducts|popular" data-mpc-unwrap="1"></div>
    ##if $popular}
    <div class="offset-top">
        <h2 data-mpc-field="title">Популярные товары</h2>

        <div class="columns">
            ##$popular}
            <div class="column col-4 sm-col-6" data-mpc-remove="1" data-mpc-chunk="msproducts/popular/item.tpl">
                <a href="{$uri}" class="element">
                    {if $popular}
                        <div class="element-label">Бестселлер</div>
                    {/if}
                    <div class="element-image">
                        <img src="{$img}" width="305" height="344" alt="{$pagetitle}">
                    </div>
                    <div class="element-content">
                        <div class="element-title">{$pagetitle}</div>
                        <div class="element-info">Вознаграждение Вознаграждение {$price}&nbsp;₽</div>
                    </div>
                </a>
            </div>
        </div>

    </div>
    ##/if}
    ##/if}
</div>

<!--showcase-->
<div id="{$id}" data-mpc-section="our_tg" data-mpc-name="Наш Telegram" data-mpc-static="1" class="offset-top">
    <div class="tg-showcase">
        <div class="tg-showcase__warp">
            <div class="tg-showcase__content">
                <div class="tg-showcase__title" data-mpc-field="title">
                    Присоединяйтесь к сообществу дизайнеров в Телеграме
                </div>
                <div class="tg-showcase__text" data-mpc-field="content">
                    Подпишитесь на нас, чтобы узнавать о выходе новых
                    товаров для печати, получать советы и интересные идеи
                </div>
                <ul class="tg-showcase__list" data-mpc-field="list_simple">
                    <li data-mpc-item><span data-mpc-field-1="content" data-mpc-unwrap="1">Советы по созданию товаров</span></li>
                    <li data-mpc-item><span data-mpc-field-1="content" data-mpc-unwrap="1">Объявления и новости проекта</span></li>
                    <li data-mpc-item><span data-mpc-field-1="content" data-mpc-unwrap="1">Обсуждения дизайна и продаж</span></li>
                    <li data-mpc-item><span data-mpc-field-1="content" data-mpc-unwrap="1">Общение с коллегами</span></li>
                </ul>
                <div class="tg-showcase__footer">
                    <a href="{51973 | resource: 'content'}" class="btn btn--full" target="_blank" data-mpc-field="target">
                        <span data-mpc-field="btn_text" data-mpc-unwrap="1">Подписаться</span>
                    </a>
                </div>
            </div>
            <div class="tg-showcase__image">
                <img src="assets/project_files/v2/img/lk/tg-showcase-image.png" data-mpc-field="img" alt="" loading="lazy" width="402" height="477">
            </div>
        </div>
    </div>
</div>

<div id="{$id}" data-mpc-section="user_faq" data-mpc-name="ЧАВО пользователя" data-mpc-static="1">
    ##if ('user_allow_add' | placeholder) || $_modx->resource.template !== 12}
    <div class="page-layout offset-top">
        <div class="page-layout__content container-medium">

            <div class="head">
                <div class="head-title" data-mpc-field="title">Вопросы-ответы</div>
                {if $resource.template !== 24}
                    <div class="head-more">
                        <a href="51972" data-mpc-field="target"><span data-mpc-field="btn_text" data-mpc-unwrap="1">Читать всё</span></a>
                    </div>
                {/if}
            </div>

            <div class="page" data-mpc-field="subtitle">
                Ответы на многие вопросы вы найдете в нашем разделе часто задаваемых вопросов
            </div>

            <div data-tab-wrapper data-mpc-snippet="getFAQ|default">
                <div data-mpc-unwrap="1" data-mpc-chunk="getfaq/default/wrap.tpl">
                    <div class="round-tabs">
                        {$nav}
                        <button data-tab-target="{$type}" data-mpc-remove="1" type="button" class="round-tabs__item {$active ? 'active' : ''}"
                                data-mpc-chunk="getfaq/default/nav_item.tpl">{$typeName}</button>
                    </div>
                    <div class="faq-tab-wrapper">
                        {$tabs}
                        <div data-tab-item="{$type}" class="faq-tab {$active ? 'active' : ''}" data-mpc-remove="1" data-mpc-chunk="getfaq/default/tab.tpl">
                            {$questions}
                            <div class="faq-item" data-mpc-remove="1" data-mpc-chunk="getfaq/default/item.tpl">
                                <div class="faq-item__title js-collapse-title">{$question}</div>
                                <div class="faq-item__content">{$answer}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div data-mpc-field="list_faq" data-mpc-remove="1">
                <div data-mpc-item="">
                    <div data-mpc-field-1="question">Вы работаете со всеми дизайнерами?</div>
                    <div data-mpc-field-1="answer">Любой дизайнер может пользоваться сервисом, если он оформил статус самозанятого.</div>
                    <div data-mpc-field-1="type">self-employment</div>
                </div>
                <div data-mpc-item="">
                    <div data-mpc-field-1="question">Сколько я могу заработать?</div>
                    <div data-mpc-field-1="answer">
                        <p>На заработок каждого дизайнера влияют несколько факторов:</p>
                        <ul>
                            <li>Количество созданных дизайнов.</li>
                            <li>Количество изделий, которые поступили в продажу.</li>
                            <li>Работа самого дизайнера по продвижению изделий со своим дизайном.</li>
                        </ul>
                        <p>То есть дизайнер, подготовивший 10 дизайнов, потенциально может заработать больше, чем создатель единственного продукта. Значение имеет качество и
                            уникальность рисунка. Примут ваш дизайн или нет, зависит от того, есть ли в нашей коллекции похожие работы. Кроме того, каждый дизайнер вправе
                            выбрать приемлемую модель поведения: совсем пассивный доход, когда изделия с вашим дизайном продаются без вашего участия. Или реклама и продвижение
                            своих дизайном через соцсети, мессенджеры и т.д. Во втором случае доход, разумеется, будет больше.</p>
                    </div>
                    <div data-mpc-field-1="type">income</div>
                </div>
                <div data-mpc-item="">
                    <div data-mpc-field-1="question">Как быстро мои товары окажутся на маркетплейсах?</div>
                    <div data-mpc-field-1="answer">
                        Срок производства товаров зависит от наличия расходных материалов, загруженности машин и очереди печати. Ориентировочный срок производства - 7 дней, он
                        может сдвигаться в сторону увеличения или уменьшения.
                    </div>
                    <div data-mpc-field-1="type">design</div>
                </div>
                <div data-mpc-item="">
                    <div data-mpc-field-1="question">Сколько файлов я должен сдать?</div>
                    <div data-mpc-field-1="answer">Мы принимаем в печать 1 файл, выполненный согласно техническим требованиям.</div>
                    <div data-mpc-field-1="type">design</div>
                </div>
                <div data-mpc-item="">
                    <div data-mpc-field-1="question">Какие технические требования к файлам?</div>
                    <div data-mpc-field-1="answer">
                        Технические характеристики файла зависят от вида продукта. Для фотообоев, подушек, картин требования к изображению будут разные. Их можно посмотреть на
                        странице товара.
                    </div>
                    <div data-mpc-field-1="type">design</div>
                </div>
                <div data-mpc-item="">
                    <div data-mpc-field-1="question">Почему мы работаем с самозанятыми?</div>
                    <div data-mpc-field-1="answer">
                        С каждым исполнителем мы заключаем договор, который будет гарантировать ваши авторские права на созданные дизайны. Концепция сервиса предполагает
                        долгосрочное сотрудничество и регулярные переводы на карту в течение долгого времени. Чтобы у налоговых органов не возникло вопросов ни к нам, как к
                        организации, ни к нашим дизайнерам, мы сразу выбрали оптимальный – «белый» режим работы.
                    </div>
                    <div data-mpc-field-1="type">self-employment</div>
                </div>
                <div data-mpc-item="">
                    <div data-mpc-field-1="question">Какой документ подтверждает статус самозанятого?</div>
                    <div data-mpc-field-1="answer">Статус самозанятого подтверждается справкой о постановке на учет в качестве плательщика НПД. Получить этот документ можно в
                        приложении «Мой налог» или же заказать в веб-версии приложения. Именно эту справку вы должны предоставить, чтобы работать в сервисе Сustomfactory.
                        Наличие статуса самозанятого будет проверяться каждый раз при оформлении вам агентских вознаграждений перед переводом средств на вашу карту.
                    </div>
                    <div data-mpc-field-1="type">self-employment</div>
                </div>
                <div data-mpc-item="">
                    <div data-mpc-field-1="question">Почему дизайнеру выгодно быть самозанятым?</div>
                    <div data-mpc-field-1="answer">
                        <ul>
                            <li><b>Спокойствие. </b>Работа «в серую» многих напрягает тем, что вас могут вычислить, отследить доходы, прийти с проверкой, заставить отчитаться.
                                Статус самозанятого позволяет спокойно работать, не отвлекаясь на пустые тревоги.
                            </li>
                            <li>Можно размещать рекламу.</b> Вы можете рекламировать свои работы при помощи соцсетей и тем самым увеличивать собственный доход. Чем больше
                                предметов с вашим дизайном будет продано, тем выше наши отчисления вам.
                            </li>
                            <li>Перспективы. </b>С самозанятыми охотно работают юридические лица. Зарегистрировав самозанятость для нашего сервиса, вы сможете зарабатывать
                                деньги и в других местах.
                            </li>
                            <li>Совмещение. </b>Самозанятость не станет препятствием, если вы уже официально трудоустроены. Например, вы работаете штатным дизайнером в
                                компании и получаете дополнительный легальный доход как самозанятый в нашем сервисе.
                            </li>
                        </ul>
                    </div>
                    <div data-mpc-field-1="type">self-employment</div>
                </div>
                <div data-mpc-item="">
                    <div data-mpc-field-1="question">Как стать самозанятым?</div>
                    <div data-mpc-field-1="answer">
                        <p>Самозанятыми называют плательщиков налога на профессиональный доход (НПД). Самозанятые работают на себя, платят низкий налог НПД 4-6%, не нанимают
                            работников, не платят страховые взносы и не сдают отчёты. </p>
                        <p>Регистрация проходит онлайн и занимает 10 минут. Есть четыре способа зарегистрироваться: на сайте налоговой (ФНС), в приложении «Мой налог», на
                            портале «Госуслуги» или в личном кабинете крупных банков. Для этого понадобятся ИНН и пароль от личного кабинета на сайте ФНС, данные паспорта или
                            учетная запись на портале Госуслуг.</p>
                    </div>
                    <div data-mpc-field-1="type">self-employment</div>
                </div>
                <div data-mpc-item="">
                    <div data-mpc-field-1="question">Можно ли одновременно быть самозанятым и официально трудоустроенным?</div>
                    <div data-mpc-field-1="answer">
                        Вы можете совмещать основную работу с дополнительной профессиональной деятельностью. При этом работодатель будет оплачивать за вас НДФЛ 13% с дохода от
                        работы по трудовому договору, а вы сами будете дополнительно оплачивать налог на профессиональный доход.
                    </div>
                    <div data-mpc-field-1="type">self-employment</div>
                </div>
                <div data-mpc-item="">
                    <div data-mpc-field-1="question">Будут ли у меня брать налоги с каждого поступления на карту?</div>
                    <div data-mpc-field-1="answer">
                        Нет, самозанятый сам декларирует сумму дохода ежемесячно. После поступления средств на счет вы самостоятельно создаёте электронный чек, подтверждающий
                        полученный доход. ФНС учтёт сумму чека при расчёте налога. Если поступившие на счет деньги не относятся к вашему профессиональному доходу – например,
                        если это перевод от друга, родственника и т.п., вы не формируете чек и эти деньги не учитываются при подсчете налога.
                    </div>
                    <div data-mpc-field-1="type">income</div>
                </div>
                <div data-mpc-item="">
                    <div data-mpc-field-1="question">Если я решу перестать быть самозанятым, это легко сделать?</div>
                    <div data-mpc-field-1="answer">Перестать быть самозанятым так же просто, как зарегистрироваться в качестве самозанятого. Если вы регистрировались через
                        приложение банка, нужно будет просто отключить сервис.
                    </div>
                    <div data-mpc-field-1="type">self-employment</div>
                </div>
                <div data-mpc-item="">
                    <div data-mpc-field-1="question">Есть ли ограничение по месячному доходу самозанятого?</div>
                    <div data-mpc-field-1="answer"><p>Для самозанятых есть ограничение по объему годового дохода — он не должен превысить 2,4 миллиона рублей. Ограничения по
                            объёму дохода за месяц нет: в один месяц вы можете получить 500 000 рублей, в другой — 50 000, в третий — 0. Важно не превысить годовое
                            ограничение.</p>
                        <p>Если вы превысите годовой лимит, придётся перейти на другой налоговый режим – например, оформить статус индивидуального предпринимателя (ИП).</p>
                    </div>
                    <div data-mpc-field-1="type">income</div>
                </div>
                <div data-mpc-item="">
                    <div data-mpc-field-1="question">Какие действия мне потребуется совершать в качестве самозанятого?</div>
                    <div data-mpc-field-1="answer"><p>Самозанятый должен делать всего две вещи:</p>
                        <ol>
                            <li>1. При каждом получении денег от нашего сервиса — сформировать и передать нам чек. Как в магазине при покупке любого товара вам обязаны выдать
                                кассовый чек, так и вы после оплаты должны отправить чек. Формирование чеков — ваша личная ответственность как плательщика налога на
                                профессиональный доход.
                            </li>
                            <li>2. Платить налог каждый месяц, если в этом месяце вы получали доход.</li>
                        </ol>
                    </div>
                    <div data-mpc-field-1="type">self-employment</div>
                </div>
                <div data-mpc-item="">
                    <div data-mpc-field-1="question">Где и как выставлять чек?</div>
                    <div data-mpc-field-1="answer">
                        <p>Учет доходов, с которых надо заплатить налог, ведется через приложение, в котором вы оформляли самозанятость. Например, «Мой налог».</p>
                        <p>Когда вы получили выплаты с нашего сервиса, вы заявляете о поступлении как о доходе в своем приложении. Тут же, в приложении, формируется ссылка на
                            чек — его надо передать нам.</p>
                        <p>Передать чек нам можно такими способами:</p>
                        <ul>
                            <li>отправить по смс или через мессенджеры, например в «Телеграме»;</li>
                            <li>выслать на электронную почту.</li>
                        </ul>
                    </div>
                    <div data-mpc-field-1="type">income</div>
                </div>
                <div data-mpc-item="">
                    <div data-mpc-field-1="question">Если в этом месяце дохода не было, какой будет налог?</div>
                    <div data-mpc-field-1="answer">
                        У самозанятого нет фиксированных платежей — большое преимущество этого налогового режима. Нет поступлений — нет налога. Если вы решили отдохнуть,
                        налоги и сборы за дни «простоя» платить не надо.
                    </div>
                    <div data-mpc-field-1="type">income</div>
                </div>
                <div data-mpc-item="">
                    <div data-mpc-field-1="question">Что такое налоговый вычет для самозанятых и как он работает?</div>
                    <div data-mpc-field-1="answer">
                        Каждому самозанятому при постановке на учет полагается сумма для уменьшения налога — 10 тысяч рублей. Ее нельзя обналичить, можно только уменьшать за
                        счет этой суммы налог – до тех пор, пока эти деньги не закончатся. Работает это так. Первое время вы будете платить не 4, а 3% налога от дохода. И так
                        можно будет делать, пока эти 10 тысяч рублей не израсходуются. Налоговый вычет дают только один раз в жизни самозанятого – в качестве бонуса за
                        использование этого налогового режима.
                    </div>
                    <div data-mpc-field-1="type">income</div>
                </div>
                <div data-mpc-item="">
                    <div data-mpc-field-1="question">Как получить кредит?</div>
                    <div data-mpc-field-1="answer">
                        <p>Для подтверждения дохода вы можете запросить справку через приложение «Мой налог» или в личном кабинете на сайте ФНС. Другой вариант — предоставить
                            справку по форме банка. Туда можно вписать любые доходы, в том числе неофициальные: проверять их не будут.</p>
                        <p>Пока статус самозанятого никак не влияет на решение банка выдать кредит: банки достаточно консервативны и предпочитают иметь дело с кредиторами,
                            которые могут подтвердить свой доход и постоянную занятость через работодателя. Однако количество самозанятых постоянно растет, поэтому многие
                            крупные банки заявляют, что готовят спецпредложения по кредитам для самозанятых.</p>
                    </div>
                    <div data-mpc-field-1="type">income</div>
                </div>
            </div>
        </div>

        <div class="page-layout__aside" data-mpc-snippet="pdoResources|help_aside_short"></div>
    </div>
    ##/if}
</div>
