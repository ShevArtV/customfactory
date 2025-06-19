
            {foreach $categories as $name => $products}
                <div class="offset-top offset-top--small">
                    <h2>{$name}</h2>
                    <div class="columns">
                        {foreach $products as $p}
                            <div class="column col-3 lg-col-4 sm-col-6">
                                <a href="{$p.uri}" class="element">
                                    {if $p.new}
                                        <div class="element-label">Новинка</div>
                                    {/if}
                                    {if $p.popular}
                                        <div class="element-label">Бестселлер</div>
                                    {/if}
                                    <div class="element-image">
                                        <img src="{$p.img}" alt="">
                                    </div>
                                    <div class="element-content">
                                        <div class="element-title">{$p.pagetitle}</div>
                                        <div class="element-info">Вознаграждение {$p.price} ₽</div>
                                    </div>
                                </a>
                            </div>
                        {/foreach}
                    </div>
                </div>
            {/foreach}
        