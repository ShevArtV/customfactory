<div id="{$id}">
    <div class="container-medium">
        <div class="page input-group">{$content}</div>
    </div>
    ##set $parents = $_modx->runSnippet('@FILE snippets/product/snippet.getparents.php', ['showUnpublished' => 1])}
    ##set $types = $_modx->runSnippet('@FILE snippets/product/snippet.gettypes.php', ['showUnpublished' => 1])}
    ##'!ffFiltering' | snippet: [
                        'configId' => '2',
'limit' => '12',
'hooks' => '',
'wrapper' => '@FILE chunks/fffiltering/designs/ffouter.tpl',
'empty' => '@FILE chunks/fffiltering/designs/ffempty.tpl',
'defaultTplOuter' => '@FILE chunks/fffiltering/designs/fffcheckboxgroupouter.tpl',
'defaultTplRow' => '@FILE chunks/fffiltering/designs/ffcheckboxgroup.tpl',
'createdonTplOuter' => '',
'createdonTplRow' => '',
'tpl' => '@FILE chunks/fffiltering/designs/item.tpl',
'sortby' => '{ "Resource.id":"DESC"}',
'element' => '@FILE snippets/product/snippet.render.php',
'categories' => $parents,
'types' => $types,
]}
    
    <div id="workflow" aria-hidden="false" class="modal">
        <div class="modal-main" style="max-width: 900px; width: 95%;">
            {set $imgPrefix = $_modx->config.file_prefix}
            <div class="modal-close" data-modal-close=""></div>
            <form data-si-form="modalProductStatus" data-si-nosave enctype="multipart/form-data" class="modal-area modal-content scrollbar" style="max-height: 80vh;">
                <input type="hidden" name="selected_id[]" value="{$id}">
                <div class="good-items">
                    {foreach $workflow as $item index=$i}
                        {if $i === 0}
                        {/if}
                        
                        {if $i == count($workflow) - 1}
                            <div class="good-item">
                                <div class="columns">
                                    <div class="column col-6 md-col-12">
                                        <div class="good-images" style="gap: 15px; margin-bottom: 20px;">
                                            {if $item.screens}
                                                {foreach ($item.screens | split: '|') as $img index=$imgIdx}
                                                    <div class="good-image">
                                                        <a href="{$site_url}{$img}" data-fancybox="gallery-{$id}" class="good-image__img">
                                                            <img src="{$site_url}{$img}" alt="" style="max-width: 100%; height: auto;">
                                                        </a>
                                                        <a href="{$site_url}{$img}" download="" class="good-image__title" style="word-break: break-all;">Скачать</a>
                                                    </div>
                                                {/foreach}
                                            {/if}
                                            
                                            {if $item.preview}
                                                {foreach ($item.preview | split: '|') as $img index=$imgIdx}
                                                    <div class="good-image">
                                                        <a href="{$imgPrefix}{$img}" data-fancybox="gallery-{$id}" class="good-image__img">
                                                            <img src="{$imgPrefix}{$img}" alt="" style="max-width: 100%; height: auto;">
                                                        </a>
                                                        <a href="{$imgPrefix}{$img}" download="" class="good-image__title" style="word-break: break-all;">Скачать</a>
                                                    </div>
                                                {/foreach}
                                            {/if}
                                        </div>
                                        <div data-fu-wrap data-si-preset="upload_screens" data-si-nosave>
                                            <input type="hidden" name="filelist" form="toRework" data-fu-list>
                                            <div data-fu-progress=""></div>
                                            <template data-fu-tpl>
                                                <div class="good-image" data-fu-path="$path">
                                                    <div class="good-image__close"></div>
                                                    <div class="good-image__img">
                                                        <img src="$path" alt="">
                                                    </div>
                                                    <div class="good-image__title" style="word-break: break-all;">$filename</div>
                                                </div>
                                            </template>
                                            <div class="good-images" style="width:100%;flex-wrap:wrap;gap:15px;" data-fu-dropzone>
                                                <div class="good-image">
                                                    <div class="good-image__add">
                                                        <span>Загрузите скриншоты</span>
                                                        <input data-fu-field multiple type="file" form="toRework" class="good-image__file">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="good-list" style="margin-top: 20px;">
                                            <div class="good-item__title">Проверить файлы</div>
                                            <ul class="good-list__files">
                                                {foreach ($item.print | split: '|') as $img index=$i}
                                                    <li><a href="{$imgPrefix}{$img}" download target="_blank">Печатный файл №{$i+1}</a></li>
                                                {/foreach}
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="column col-6 md-col-12">
                                        <div class="good-reports">
                                            {if $item.designer_comment}
                                                <div class="good-report">
                                                    <div class="good-report__date">От дизайнера: {$item.designer_date}</div>
                                                    <div class="good-report__quote" style="word-wrap: break-word;">
                                                        {$item.designer_comment}
                                                    </div>
                                                </div>
                                            {/if}
                                            {if $item.moderator_comment}
                                                <div class="good-report good-report__right">
                                                    <div class="good-report__date">От модератора: {$item.moderator_date}</div>
                                                    <div class="good-report__quote" style="word-wrap: break-word;">
                                                        {$item.moderator_comment}
                                                    </div>
                                                </div>
                                            {/if}

                                            <textarea class="input textarea" name="content" data-sync="#content" placeholder="Введите комментарий" style="min-height: 120px; margin: 20px 0;"></textarea>

                                            <div class="good-report">
                                                <div class="good-item__title" style="margin-bottom: 15px;">
                                                    Установить статус:
                                                </div>
                                                <div class="btn-group" style="flex-wrap: wrap; gap: 10px;">
                                                    <div class="js-custom-select select-pill">
                                                        <select class="" name="status">
                                                            {foreach $statuses['product'] as $sid => $data}
                                                                {if ($sid in list $statuses['product'][$status]['allow']) && $sid !== 7}
                                                                    <option value="{$sid}">{$data.caption}</option>
                                                                {/if}
                                                            {/foreach}
                                                        </select>
                                                    </div>
                                                    <button type="button" class="btn btn--small" data-si-event="click" data-si-preset="changeStatus">Отправить</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {else}
                            <div class="good-item">
                                <div class="columns">
                                    <div class="column col-6 md-col-12">
                                        <div class="good-images" style="gap: 15px; margin-bottom: 20px;">
                                            {if $item.screens}
                                                {foreach ($item.screens | split: '|') as $img index=$imgIdx}
                                                    <div class="good-image">
                                                        <a href="{$site_url}{$img}" data-fancybox="gallery-{$id}" class="good-image__img">
                                                            <img src="{$site_url}{$img}" alt="" style="max-width: 100%; height: auto;">
                                                        </a>
                                                        <a href="{$site_url}{$img}" download="" class="good-image__title" style="word-break: break-all;">Скачать</a>
                                                    </div>
                                                {/foreach}
                                            {/if}
                                            
                                            {if $item.preview}
                                                {foreach ($item.preview | split: '|') as $img index=$imgIdx}
                                                    <div class="good-image">
                                                        <a href="{$imgPrefix}{$img}" data-fancybox="gallery-{$id}" class="good-image__img">
                                                            <img src="{$imgPrefix}{$img}" alt="" style="max-width: 100%; height: auto;">
                                                        </a>
                                                        <a href="{$imgPrefix}{$img}" download="" class="good-image__title" style="word-break: break-all;">Скачать</a>
                                                    </div>
                                                {/foreach}
                                            {/if}
                                        </div>
                                    </div>
                                    <div class="column col-6 md-col-12">
                                        <div class="good-reports">
                                            {if $item.designer_comment}
                                                <div class="good-report">
                                                    <div class="good-report__date">{$item.designer_date}</div>
                                                    <div class="good-report__quote" style="word-wrap: break-word;">
                                                        {$item.designer_comment}
                                                    </div>
                                                </div>
                                            {/if}
                                            {if $item.moderator_comment}
                                                <div class="good-report good-report__right">
                                                    <div class="good-report__date">{$item.moderator_date}</div>
                                                    <div class="good-report__quote" style="word-wrap: break-word;">
                                                        {$item.moderator_comment}
                                                    </div>
                                                </div>
                                            {/if}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {/if}
                    {/foreach}
                </div>
            </form>
            {if $status in list [1,2,7]}
                <form id="toRework" data-si-form class="modal-footer center" style="padding: 15px 0;">
                    <input type="hidden" name="selected_id[]" value="{$id}">
                    <input type="hidden" name="status" value="7">
                    <input type="hidden" name="content" id="content" value="">
                    <button type="button" class="btn btn--small btn--line" data-si-preset="toRework" data-si-event="click">На доработку</button>
                </form>
            {/if}
        </div>
    </div>

</div>