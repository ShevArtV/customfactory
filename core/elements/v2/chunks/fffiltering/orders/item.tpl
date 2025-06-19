<tr>
                    <td>
                        <div class="statistic-table__wrap">
                            <ul class="statistic-table__images">
                                {set $previews = $preview | split: '|'}
                                {if $previews}
                                    {foreach $previews as $path}
                                        <li>
                                            <img src="{$_modx->config.file_prefix}{$path}" alt="">
                                        </li>
                                    {/foreach}
                                {/if}
                            </ul>
                            <div class="statistic-table__content">
                                <div class="statistic-table__title">{$types[$root_id]}</div>
                                <ul class="statistic-table__params">
                                    <li>Создан {$createdon | date: 'd.m.Y H:i'}</li>
                                    <li>Артикул: {$article}</li>
                                    <li>Вознаграждение: {$price}₽</li>
                                </ul>
                            </div>
                        </div>
                    </td>
                    <td>
                        <ul class="statistic-table__info">
                            <li>Заказов: {$orders?:0}</li>
                            <li>Выкупов: {$sales?:0}</li>
                            <li>Возвратов: {$returns?:0}</li>
                        </ul>
                    </td>
                    <td>
                        <div class="statistic-table__total">
                            Сумма выплат:
                            <span class="red">{$pays?:0} ₽</span>
                        </div>
                    </td>
                </tr>