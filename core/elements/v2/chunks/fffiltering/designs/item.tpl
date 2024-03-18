<div class="column col-4 md-col-6 sm-col-12" id="product-{$id}">
                    <div class="card-design">
                        <div class="card-design__check">
                            <label class="checkbox-label">
                                <input type="checkbox" class="checkbox">
                                <span class="checkbox-text"></span>
                            </label>
                        </div>

                        <ul class="card-design__images">
                            <li style="background-image: url(img/2023-12-23_123120.jpg)">
                            </li>
<li style="background-image: url(img/2023-12-23_123120.jpg)">
                            </li>
<li style="background-image: url(img/2023-12-23_123120.jpg)">
                        </li>
</ul>
                        <div class="card-design__content">
                            <div class="card-design__title">{$pagetitle}</div>
                            <ul class="card-design__params">
                                <li>Номер ЛК: {$createdby | user: 'profile_num'} ({$createdby})</li>
                            </ul>
                        </div>
                        <div class="card-design__footer">
                            <ul class="card-design__params">
                                <li class="active">Статус: {$status}</li>
                                <li>Категория: <a href="">{$parent | resource: 'pagetitle'}</a>
</li>
                                <li>Тэг: <a href="">{$tags[0]}</a>
</li>
                                <li>Цвета:
                                    {foreach $color as $c last=$l}
                                        <a href="">{$c}</a>{if !$l},{/if}
                                    {/foreach}
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>