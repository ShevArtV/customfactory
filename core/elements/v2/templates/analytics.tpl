<!--##{"templatename":"Аналитика","pagetitle":"Аналитика","icon":"icon-chart-bar","extends":"12"}##-->
<!-- php7.4 www/core/components/migxpageconfigurator/console/mgr_tpl.php web user_analytics.tpl -->
<div id="{$id}" data-mpc-section="user_analytics" data-mpc-name="Аналитика">
    <div class="container-small">
        <div class="page" data-mpc-field="content">
            Выберите вкладку для просмотра аналитики.
        </div>
    </div>

    <div class="tabs">
        <ul class="tabs-nav">
            <li class="tabs-nav-item active" data-tab="structure">Структура товаров</li>
            <li class="tabs-nav-item" data-tab="themes">Тематики</li>
            <li class="tabs-nav-item" data-tab="general">Общая аналитика</li>
            <li class="tabs-nav-item" data-tab="seasonal">Сезонная аналитика</li>
            <li class="tabs-nav-item" data-tab="marketplaces">Маркетплейсы</li>
        </ul>

        <div class="tabs-content">
            <div class="tabs-content-item active" id="structure">
                <!-- Структура товаров -->
                <div class="statistic-showcase">
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Количество товаров в каждой категории</div>
                        <div class="statistic-showcase__value">
                            <!-- SQL запрос для подсчета количества товаров в каждой категории -->
                            <pre>
SELECT
    root_id AS category_id,
    COUNT(*) AS total_products
FROM
    cust_ms2_products
GROUP BY
    root_id;
                            </pre>
                        </div>
                    </div>
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Популярность категорий</div>
                        <div class="statistic-showcase__value">
                            <!-- SQL запрос для определения наиболее популярных категорий на основе количества продаж -->
                            <pre>
SELECT
    p.root_id AS category_id,
    SUM(i.sales) AS total_sales
FROM
    cust_outerstatistics_items i
JOIN
    cust_ms2_products p ON i.product_id = p.id
GROUP BY
    p.root_id
ORDER BY
    total_sales DESC;
                            </pre>
                        </div>
                    </div>
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Количество товаров каждого цвета</div>
                        <div class="statistic-showcase__value">
                            <!-- SQL запрос для подсчета количества товаров каждого цвета -->
                            <pre>
SELECT
    color,
    COUNT(*) AS total_products
FROM
    cust_ms2_products
GROUP BY
    color;
                            </pre>
                        </div>
                    </div>
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Популярность цветов</div>
                        <div class="statistic-showcase__value">
                            <!-- SQL запрос для определения наиболее популярных цветов на основе количества продаж -->
                            <pre>
SELECT
    p.color,
    SUM(i.sales) AS total_sales
FROM
    cust_outerstatistics_items i
JOIN
    cust_ms2_products p ON i.product_id = p.id
GROUP BY
    p.color
ORDER BY
    total_sales DESC;
                            </pre>
                        </div>
                    </div>
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Количество товаров с каждым тэгом</div>
                        <div class="statistic-showcase__value">
                            <!-- SQL запрос для подсчета количества товаров с каждым тэгом -->
                            <pre>
SELECT
    tag_label,
    COUNT(*) AS total_products
FROM
    cust_ms2_products
GROUP BY
    tag_label;
                            </pre>
                        </div>
                    </div>
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Популярность тэгов</div>
                        <div class="statistic-showcase__value">
                            <!-- SQL запрос для определения наиболее популярных тэгов на основе количества продаж -->
                            <pre>
SELECT
    p.tag_label,
    SUM(i.sales) AS total_sales
FROM
    cust_outerstatistics_items i
JOIN
    cust_ms2_products p ON i.product_id = p.id
GROUP BY
    p.tag_label
ORDER BY
    total_sales DESC;
                            </pre>
                        </div>
                    </div>
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Количество своих товаров среди всех товаров по тэгам</div>
                        <div class="statistic-showcase__value">
                            <!-- SQL запрос для подсчета количества своих товаров среди всех товаров по тэгам -->
                            <pre>
SELECT
    p.tag_label AS tag_id,
    COUNT(*) AS total_products,
    (SELECT COUNT(*) FROM cust_ms2_products WHERE tag_label = p.tag_label) AS tag_products
FROM
    cust_ms2_products p
GROUP BY
    p.tag_label;
                            </pre>
                        </div>
                    </div>
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Количество продаж товаров дизайнера в денежном эквиваленте среди продаж всех товаров всех клиентов</div>
                        <div class="statistic-showcase__value">
                            <!-- SQL запрос для подсчета общей суммы продаж товаров каждого дизайнера и сравнения её с общей суммой продаж всех товаров -->
                            <pre>
SELECT
    p.designer AS designer_id,
    SUM(i.sales * p.price) AS designer_sales,
    (SELECT SUM(sales * price) FROM cust_outerstatistics_items i JOIN cust_ms2_products p ON i.product_id = p.id) AS total_sales
FROM
    cust_outerstatistics_items i
JOIN
    cust_ms2_products p ON i.product_id = p.id
GROUP BY
    p.designer;
                            </pre>
                        </div>
                    </div>
                </div>
            </div>

            <div class="tabs-content-item" id="themes">
                <!-- Тематики -->
                <div class="statistic-showcase">
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Количество товаров каждого дизайнера</div>
                        <div class="statistic-showcase__value">
                            <!-- SQL запрос для подсчета количества товаров каждого дизайнера -->
                            <pre>
SELECT
    designer,
    COUNT(*) AS total_products
FROM
    cust_ms2_products
GROUP BY
    designer;
                            </pre>
                        </div>
                    </div>
                </div>
            </div>

            <div class="tabs-content-item" id="general">
                <!-- Общая аналитика -->
                <div class="statistic-showcase">
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Общее количество продаж за период</div>
                        <div class="statistic-showcase__value">
                            <!-- SQL запрос для подсчета общего количества продаж за определенный период -->
                            <pre>
SELECT
    COUNT(*) AS total_sales
FROM
    cust_outerstatistics_items
WHERE
    date BETWEEN UNIX_TIMESTAMP('2024-01-01 00:00:00') AND UNIX_TIMESTAMP('2024-12-31 23:59:59');
                            </pre>
                        </div>
                    </div>
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Общее количество возвратов за период</div>
                        <div class="statistic-showcase__value">
                            <!-- SQL запрос для подсчета общего количества возвратов за определенный период -->
                            <pre>
SELECT
    SUM(returns) AS total_returns
FROM
    cust_outerstatistics_items
WHERE
    date BETWEEN UNIX_TIMESTAMP('2024-01-01 00:00:00') AND UNIX_TIMESTAMP('2024-12-31 23:59:59');
                            </pre>
                        </div>
                    </div>
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Общее количество заказов за период</div>
                        <div class="statistic-showcase__value">
                            <!-- SQL запрос для подсчета общего количества заказов за определенный период -->
                            <pre>
SELECT
    SUM(orders) AS total_orders
FROM
    cust_outerstatistics_items
WHERE
    date BETWEEN UNIX_TIMESTAMP('2024-01-01 00:00:00') AND UNIX_TIMESTAMP('2024-12-31 23:59:59');
                            </pre>
                        </div>
                    </div>
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Общая плата дизайнерам за период</div>
                        <div class="statistic-showcase__value">
                            <!-- SQL запрос для подсчета общей платы дизайнерам за определенный период -->
                            <pre>
SELECT
    SUM(pays) AS total_pays
FROM
    cust_outerstatistics_items
WHERE
    date BETWEEN UNIX_TIMESTAMP('2024-01-01 00:00:00') AND UNIX_TIMESTAMP('2024-12-31 23:59:59');
                            </pre>
                        </div>
                    </div>
                </div>
            </div>

            <div class="tabs-content-item" id="seasonal">
                <!-- Сезонная аналитика -->
                <div class="statistic-showcase">
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Продажи по месяцам</div>
                        <div class="statistic-showcase__value">
                            <!-- SQL запрос для анализа количества продаж по каждому месяцу -->
                            <pre>
SELECT
    DATE_FORMAT(FROM_UNIXTIME(date), '%Y-%m') AS month,
    COUNT(*) AS total_sales
FROM
    cust_outerstatistics_items
WHERE
    date BETWEEN UNIX_TIMESTAMP('2024-01-01 00:00:00') AND UNIX_TIMESTAMP('2024-12-31 23:59:59')
GROUP BY
    month;
                            </pre>
                        </div>
                    </div>
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Продажи по кварталам</div>
                        <div class="statistic-showcase__value">
                            <!-- SQL запрос для анализа количества продаж по каждому кварталу -->
                            <pre>
SELECT
    QUARTER(FROM_UNIXTIME(date)) AS quarter,
    COUNT(*) AS total_sales
FROM
    cust_outerstatistics_items
WHERE
    date BETWEEN UNIX_TIMESTAMP('2024-01-01 00:00:00') AND UNIX_TIMESTAMP('2024-12-31 23:59:59')
GROUP BY
    quarter;
                            </pre>
                        </div>
                    </div>
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Продажи по сезонам</div>
                        <div class="statistic-showcase__value">
                            <!-- SQL запрос для анализа количества продаж по сезонам -->
                            <pre>
SELECT
    CASE
        WHEN MONTH(FROM_UNIXTIME(date)) IN (3, 4, 5) THEN 'Весна'
        WHEN MONTH(FROM_UNIXTIME(date)) IN (6, 7, 8) THEN 'Лето'
        WHEN MONTH(FROM_UNIXTIME(date)) IN (9, 10, 11) THEN 'Осень'
        WHEN MONTH(FROM_UNIXTIME(date)) IN (12, 1, 2) THEN 'Зима'
    END AS season,
    COUNT(*) AS total_sales
FROM
    cust_outerstatistics_items
WHERE
    date BETWEEN UNIX_TIMESTAMP('2024-01-01 00:00:00') AND UNIX_TIMESTAMP('2024-12-31 23:59:59')
GROUP BY
    season;
                            </pre>
                        </div>
                    </div>
                </div>
            </div>

            <div class="tabs-content-item" id="marketplaces">
                <!-- Маркетплейсы -->
                <div class="statistic-showcase">
                    <div class="statistic-showcase__item">
                        <div class="statistic-showcase__title">Продажи по каждому маркетплейсу</div>
                        <div class="statistic-showcase__value">
                            <!-- SQL запрос для анализа количества продаж по каждому маркетплейсу -->
                            <pre>
SELECT
    market,
    COUNT(*) AS total_sales
FROM
    cust_outerstatistics_items
WHERE
    date BETWEEN UNIX_TIMESTAMP('2024-01-01 00:00:00') AND UNIX_TIMESTAMP('2024-12-31 23:59:59')
GROUP BY
    market;
                            </pre>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
