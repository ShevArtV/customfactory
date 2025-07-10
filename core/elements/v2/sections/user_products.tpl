<div id="{$id}">
    <div class="container-medium">
        <div class="page input-group">{$content}</div>
    </div>
    ##set $parents = $_modx->runSnippet('@FILE snippets/product/snippet.getparents.php', ['showUnpublished' => 1])}
    ##set $types = $_modx->runSnippet('@FILE snippets/product/snippet.gettypes.php', ['showUnpublished' => 1])}
    ##'!ffGetFilterForm' | snippet: [
                        'configId' => '2',
'wrapper' => '@FILE chunks/fffiltering/designs/ffform.tpl',
'defaultTplOuter' => '@FILE chunks/fffiltering/designs/fffcheckboxgroupouter.tpl',
'defaultTplRow' => '@FILE chunks/fffiltering/designs/ffcheckboxgroup.tpl',
'createdonTplOuter' => '',
'createdonTplRow' => '',
'categories' => $parents,
'types' => $types,
'presetName' => 'flatfilters',
]}

    ##set $presetName = 'filters.presetName' | placeholder}
    <div class="columns" data-pn-result="filters">##'!Pagination' | snippet: [
                        'configId' => '2',
'render' => '@FILE snippets/product/snippet.render.php',
'snippet' => '!Pagination',
'presetName' => $presetName,
'pagination' => 'filters',
'resultBlockSelector' => '[data-pn-result="filters"]',
'resultShowMethod' => 'insert',
'hashParams' => 'filtersHash,sortby',
'noDisabled' => '1',
'getDisabled' => '0',
'limit' => '6',
'parents' => '13',
'sortby' => '{ "Resource.id":"DESC"}',
'tpl' => '@FILE chunks/fffiltering/products/item.tpl',
'tplEmpty' => '@FILE chunks/fffiltering/designs/ffempty.tpl',
'extends' => 'pagination.designs',
]}</div>
    ##include "file:chunks/fffiltering/designs/pagination.tpl"}

    <div id="workflow" aria-hidden="false" class="modal">
        <div class="modal-main">
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
                                        <button type="button" class="btn file-list__btn" data-fu-path="$path">$filename x</button>
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