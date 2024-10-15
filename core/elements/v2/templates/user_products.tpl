<!--##{"templatename":"Товары пользователя","pagetitle":"Страница товаров пользователя","icon":"icon-th", "extends": "12"}##-->

<!-- /usr/local/php/php-7.4/bin/php /home/host1860015/art-sites.ru/htdocs/customfactory/core/components/migxpageconfigurator/console/mgr_tpl.php web user_products.tpl -->
<!-- php7.4 www/core/components/migxpageconfigurator/console/mgr_tpl.php web user_products.tpl -->
<div id="{$id}" data-mpc-section="user_products" data-mpc-name="Товары пользователя">
    <div class="container-medium">
        <div class="page input-group" data-mpc-field="content">
            Проверьте изображения от дизайнеров на соответствие техническим требованиям и допустимому содержанию
        </div>
    </div>
    ##set $parents = $_modx->runSnippet('@FILE snippets/product/snippet.getparents.php')}
    ##set $types = $_modx->runSnippet('@FILE snippets/product/snippet.gettypes.php')}
    <div data-mpc-unwrap="1" data-mpc-snippet="!ffFiltering|products">
        <div class="column col-4 xl-col-6 sm-col-12" data-mpc-remove="1" data-mpc-chunk="fffiltering/products/item.tpl">
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
                <ul class="product-images" data-mpc-attr="{if $status == 5} data-modal-show='reject-{$id}' {/if} {if $status == 7} data-load-workflow='{$id}' {/if}">
                    {set $previews = $preview | split: '|'}
                    {if $previews}
                        {foreach $previews as $path}
                            <li style="background-image: url({$_modx->config.file_prefix}{$path})"></li>
                        {/foreach}
                    {/if}
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
                    <ul class="product-articles__grid">
                        <li>
                            <div class="product-articles__name">Внутренний</div>
                            <div class="product-articles__value">
                                <span>{$article?:'не присвоен'}</span>
                            </div>
                        </li>
                        <li>
                            <div class="product-articles__name">Ozon</div>
                            <div class="product-articles__value">
                                <span>{$article_oz?:'не присвоен'}</span>
                            </div>
                        </li>
                        <li>
                            <div class="product-articles__name">WB</div>
                            <div class="product-articles__value">
                                <span>{$article_wb?:'не присвоен'}</span>
                            </div>
                        </li>
                        <li>
                            <div class="product-articles__name">Я.Маркет</div>
                            <div class="product-articles__value">
                                <span>{$article_ya?:'не присвоен'}</span>
                            </div>
                        </li>
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
                            <button type="button" class="product-delete"
                                    data-si-event="click"
                                    data-si-preset="changeDeleted"
                                    data-mpc-attr="{($status in list ['2','3','4','6','7']) ? 'disabled' : ''}">
                                Удалить <br>
                                сейчас
                            </button>
                        </form>
                    </li>
                </ul>
            </div>
        </div>
    </div>


    <div id="workflow" aria-hidden="false" class="modal">
        <div class="modal-main" data-mpc-chunk="common/workflow_designer.tpl">
            <div class="modal-close" data-modal-close=""></div>
            <form data-si-form="modalProductStatus" data-si-nosave enctype="multipart/form-data" class="modal-area modal-content scrollbar">
                <input type="hidden" name="selected_id[]" value="{$id}">
                <input type="hidden" name="maxcount" form="reloadFiles" value="{$count_files}">
                <div class="good-items">
                    {foreach $workflow as $item index=$i}
                        {set $imgPrefix = $_modx->config.file_prefix}
                        {if $item.screens}
                            {set $imgPrefix = ''}
                        {/if}
                        <div class="good-item">
                            <div class="columns">
                                <div class="column col-6 md-col-12">
                                    {if $i === 0}
                                        <ul class="good-item__params">
                                            <li>Товар: {$type}</li>
                                            <li style="display:flex;gap:5px;align-items:center;">
                                                <span class="good-item__status {$prev_status == 2 ? 'status--check' : 'status--new'}"></span>
                                                {$statuses['product'][$prev_status]['caption']}
                                            </li>
                                            <li>Тэг: {$tags[0]?:'не задан'}</li>
                                            <li>Цвета: {$color ? ($color | join: '; ') : 'не заданы'}</li>
                                        </ul>
                                    {/if}
                                    <div class="good-images">
                                        {set $images = $item.screens ?: $item.preview}
                                        {foreach ($images | split: '|') as $img index=$i}
                                            <div class="good-image">
                                                <a href="{$imgPrefix}{$img}" data-fancybox="gallery-{$id}" class="good-image__img">
                                                    <img src="{$imgPrefix}{$img}" alt="">
                                                </a>
                                                <a href="{$imgPrefix}{$img}" download="" class="good-image__title">{$img}</a>
                                            </div>
                                        {/foreach}
                                    </div>
                                </div>
                                <div class="column col-6 md-col-12">
                                    <div class="good-reports">
                                        {if $item.designer_comment}
                                            <div class="good-report">
                                                <div class="good-report__date">{$item.designer_date}</div>
                                                <div class="good-report__quote">
                                                    {$item.designer_comment}
                                                </div>
                                            </div>
                                        {/if}
                                        {if $item.moderator_comment}
                                            <div class="good-report good-report__right">
                                                <div class="good-report__date">{$item.moderator_date}</div>
                                                <div class="good-report__quote">
                                                    {$item.moderator_comment}
                                                </div>
                                            </div>
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        </div>
                    {/foreach}
                    <div class="good-item">
                        <div class="columns">
                            <div class="column col-6 md-col-12">
                                <div data-fu-wrap data-si-preset="upload_design" data-si-nosave>
                                    <input type="hidden" name="filelist" form="reloadFiles" data-fu-list>
                                    <div data-fu-progress=""></div>
                                    <label class="file-form file-attachment" data-fu-dropzone>
                                        <input type="file" name="files" data-fu-field multiple class="v_hidden" placeholder="Выберите файл">
                                        <span data-fu-hide class="file-form__text">Перетащите сюда файлы</span>
                                    </label>
                                    <template data-fu-tpl>
                                        <button type="button" class="btn file-list__btn" data-fu-path="$path">$filename&nbsp;x</button>
                                    </template>
                                </div>
                            </div>
                            <div class="column col-6 md-col-12">
                                <div class="good-reports">
                                    <textarea class="input textarea" name="data[introtext]" form="reloadFiles" placeholder="Введите ответ для модератора"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <div class="modal-footer center">
                <form id="reloadFiles" data-si-form class="modal-footer center">
                    <input type="hidden" name="data[id]" value="{$id}">
                    <input type="hidden" name="data[status]" value="{$prev_status}">
                    <button type="button" class="btn btn--small" data-si-event="click" data-si-preset="reloadFiles">На проверку</button>
                </form>
                <form data-si-form class="modal-footer center">
                    <input type="hidden" name="selected_id[]" value="{$id}">
                    <button type="button" class="btn btn--small btn--line" data-si-event="click" data-si-preset="changeDeleted">Сдаюсь и удаляю</button>
                </form>
            </div>
        </div>
    </div>

</div>
