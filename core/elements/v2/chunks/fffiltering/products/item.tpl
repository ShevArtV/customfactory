<div class="column col-4 xl-col-6 sm-col-12">
            {set $statusCaption = $statuses['product'][$status]['caption']}
            {if $status == 1 || ($prev_status == 1 && $status == 7)}
                {set $class = 'product--new'}
                {set $statusCaption = $statuses['product'][($status == 7 ? $prev_status : $status )]['caption']}
            {elseif $status == 2 || ($prev_status == 2 && $status == 7)}
                {set $class = 'product--check'}
                {set $statusCaption = $statuses['product'][($status == 7 ? $prev_status : $status )]['caption']}
            {elseif $status == 3}
                {set $class = 'product--article'}
            {elseif $status == 4}
                {set $class = 'product--sale'}
            {elseif $status == 5 || $status == 6}
                {set $class = 'product--cancel'}
            {/if}
            <div class="product {$class}">
                {if $status == 7}
                    <div class="product-label btn btn--small">На доработку</div>
                {/if}
                <ul class="product-images" {if $status == 5} data-modal-show='reject-{$id}' {/if} {if $status == 7} data-load-workflow='{$id}' {/if}>
                    {set $previews = $preview | split: '|'}
                    {if $previews}
                        {foreach $previews as $path}
                            <li style="background-image: url({$_modx->config.file_prefix}{$path})">
                        {/foreach}
                    {/if}
                </li>
</ul>

                {if $status == 5}
                    <div id="reject-{$id}" aria-hidden="false" class="modal">
                        <div class="modal-main" style="">
                            <div class="modal-close" data-modal-close=""></div>
                            <div class="modal-area modal-content scrollbar">
                                <div class="good-items">
                                    <div class="good-item">
                                        <div class="columns">
                                            <div class="column col-6 md-col-12">
                                                <ul class="good-item__params">
                                                    <li>Товар: {$types[$root_id]}</li>
                                                    <li style="display:flex;gap:5px;align-items:center;">
                                                        <span class="good-item__status status--cancel"></span>
                                                        Отклонён
                                                    </li>
                                                    <li>Тэг: {$tags[0]?:'не задан'}</li>
                                                    <li>Цвета: {$color ? ($color | join: '; ') : 'не заданы'}</li>
                                                </ul>
                                            </div>
                                            <div class="column col-6 md-col-12">
                                                <div class="good-reports">
                                                    <div class="good-report">
                                                        <div class="good-report__date">{$editedon}</div>
                                                        <div class="good-report__quote">
                                                            {$content}
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                {/if}


                <div class="product-content">
                    <div class="product-title">{$types[$root_id]}</div>
                    <ul class="product-params">
                        <li>Создан {$createdon | date: 'd.m.Y H:i'}</li>
                    </ul>
                    <div class="product-status">{$statusCaption}</div>
                </div>
                <div class="product-articles">
                    <div class="product-articles__title">Артикулы</div>
                    
                    <ul class="product-articles__grid" style="display: block;">
                        <li style="margin-bottom: 10px; width: 100%;">
                            <div class="product-articles__name">Внутренний</div>
                            <div class="product-articles__value">
                                <span>{$article?:'не присвоен'}</span>
                            </div>
                        </li>
                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 10px;">
                            <li>
                                <div class="product-articles__name">WB</div>
                                <div class="product-articles__value">
                                    <span>{$article_wb?:'не присвоен'}</span>
                                </div>
                            </li>
                            <li>
                                <div class="product-articles__name">Ozon</div>
                                <div class="product-articles__value">
                                    <span>{$article_oz?:'не присвоен'}</span>
                                </div>
                            </li>
                        </div>
                    </ul>
                </div>
                <ul class="product-footer">
                    <li>
                        <div class="product-footer__info">
                            Отклоненные товары удаляются автоматически через 30 дней
                        </div>
                    </li>
                    <li>
                        <form data-si-form>
                            <input type="hidden" name="selected_id[]" value="{$id}">
                            <button type="button" class="product-delete" data-si-event="click" data-si-preset="changeDeleted" {($status in list ['2','3','4','6','7']) ? 'disabled' : ''}>
                                Удалить <br>
                                сейчас
                            </button>
                        </form>
                    </li>
                </ul>
            </div>
        </div>