<!--##{"templatename":"Статистика продаж","pagetitle":"Страница Статистика продаж","icon":"icon-dollar","extends":"12"}##-->

<!-- /usr/local/php/php-7.4/bin/php /home/host1860015/art-sites.ru/htdocs/customfactory/core/components/migxpageconfigurator/console/mgr_tpl.php web user_orders.tpl -->

<div id="{$id}" data-mpc-section="user_orders" data-mpc-name="Статистика продаж">
    <div class="container-small">
        <div class="page">
            Чтобы посмотреть статистику по заказам за конкретную дату,
            выберите нужную дату и следующую за ней. Например, чтобы посмотреть
            статистику за 05.07.2023, нужно выбрать 05.07.2023 и 06.07.2023.
        </div>
    </div>

    <div class="container-small">

        <!--statistic-showcase-->
        <div class="statistic-showcase">
            <div class="statistic-showcase__item">
                <div class="statistic-showcase__title">
                    Всего за период <br>
                    с <span>30.01.2023</span> по <span>06.10.2023</span>
                </div>
            </div>
            <div class="statistic-showcase__item">
                <div class="statistic-showcase__title">Заказов:</div>
                <div class="statistic-showcase__value">43 шт.</div>
            </div>
            <div class="statistic-showcase__item">
                <div class="statistic-showcase__title">Продаж:</div>
                <div class="statistic-showcase__value">34 шт.</div>
            </div>
            <div class="statistic-showcase__item">
                <div class="statistic-showcase__title">Возвратов:</div>
                <div class="statistic-showcase__value">1 шт.</div>
            </div>
            <div class="statistic-showcase__item active">
                <div class="statistic-showcase__title">Выплат:</div>
                <div class="statistic-showcase__value">15 850 ₽</div>
            </div>
        </div>

    </div>

    <!--filter-->
    <div class="filter">
        <div class="filter-column">
            <div class="filter-item">
                <div class="filter-name">Дизайнов: <span>55</span></div>
            </div>
            <div class="filter-item">
                <ul class="filter-list">
                    <li>
                        <div class="filter-name filter-name--select" data-popup-link="filter-status">
                            Статус
                        </div>
                        <div class="popup-menu popup-menu--checked" data-popup="filter-status">
                            <ul>
                                <li>
                                    <label class="checkbox-label">
                                        <input type="checkbox" class="checkbox">
                                        <span class="checkbox-text checkbox-text--small">В продаже</span>
                                    </label>
                                </li>
                                <li>
                                    <label class="checkbox-label">
                                        <input type="checkbox" class="checkbox">
                                        <span class="checkbox-text checkbox-text--small">На проверке тех.требований</span>
                                    </label>
                                </li>
                                <li>
                                    <label class="checkbox-label">
                                        <input type="checkbox" class="checkbox">
                                        <span class="checkbox-text checkbox-text--small">Отклонён</span>
                                    </label>
                                </li>
                                <li>
                                    <label class="checkbox-label">
                                        <input type="checkbox" class="checkbox">
                                        <span class="checkbox-text checkbox-text--small">Присвоение артикулов</span>
                                    </label>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li>
                        <div class="filter-name filter-name--select">Категория</div>
                    </li>
                    <li>
                        <div class="filter-name filter-name--select">
                            Товар
                        </div>
                    </li>
                    <li>
                        <div class="filter-name">Тэг</div>
                    </li>
                    <li>
                        <div class="filter-name">Цвет</div>
                    </li>
                </ul>
            </div>
        </div>
        <div class="filter-column">
            <div class="filter-item">
                <div class="filter-name filter-name--select">
                    <span>Последние 7 дней</span>
                </div>
            </div>
            <div class="filter-item filter-item--search">
                <button type="button" class="filter-search"></button>
            </div>
        </div>
    </div>

    <table class="statistic-table">
        <tbody>
        <!---->
        <tr>
            <td>
                <div class="statistic-table__wrap">
                    <ul class="statistic-table__images">
                        <li>
                            <img src="img/2023-12-23_123120.jpg" alt="">
                        </li>
                    </ul>
                    <div class="statistic-table__content">
                        <div class="statistic-table__title">Интерьерная картина 30х40см</div>
                        <ul class="statistic-table__params">
                            <li>Создан 30.09.2023 11:15</li>
                            <li>Артикул: 47/251-0001929-70066</li>
                            <li>Вознаграждение: 25.00₽</li>
                        </ul>
                    </div>
                </div>
            </td>
            <td>
                <ul class="statistic-table__info">
                    <li>Заказов: 2</li>
                    <li>Выкупов: 2</li>
                    <li>Возвратов: 0</li>
                </ul>
            </td>
            <td>
                <div class="statistic-table__total">
                    Сумма выплат:
                    <span class="red">25 ₽</span>
                </div>
            </td>
        </tr>
        <!---->
        <tr>
            <td>
                <div class="statistic-table__wrap">
                    <ul class="statistic-table__images">
                        <li>
                            <img src="img/2023-12-23_123120.jpg" alt="">
                        </li>
                        <li>
                            <img src="img/2023-12-23_123120.jpg" alt="">
                        </li>
                        <li>
                            <img src="img/2023-12-23_123120.jpg" alt="">
                        </li>
                    </ul>
                    <div class="statistic-table__content">
                        <div class="statistic-table__title">Интерьерная картина 30х40см</div>
                        <ul class="statistic-table__params">
                            <li>Создан 30.09.2023 11:15</li>
                            <li>Артикул: 47/251-0001929-70066</li>
                            <li>Вознаграждение: 25.00₽</li>
                        </ul>
                    </div>
                </div>
            </td>
            <td>
                <ul class="statistic-table__info">
                    <li>Заказов: 2</li>
                    <li>Выкупов: 2</li>
                    <li>Возвратов: 0</li>
                </ul>
            </td>
            <td>
                <div class="statistic-table__total">
                    Сумма выплат:
                    <span class="red">25 ₽</span>
                </div>
            </td>
        </tr>
        </tbody>
    </table>

    <!--pagination-->
    <div class="pagination-wrap">
        <div class="pagination-list">
            Страница
            <span>1</span>
            из 21
        </div>

        <ul class="pagination">
            <li><a href="" class="disabled start"></a></li>
            <li><a href="" class="disabled prev"></a></li>
            <li><a href="">1</a></li>
            <li><a href="" class="active">2</a></li>
            <li><a href="">3</a></li>
            <li><a href="">4</a></li>
            <li><a href="">5</a></li>
            <li><a href="" class="next"></a></li>
            <li><a href="" class="end"></a></li>
        </ul>
    </div>
</div>