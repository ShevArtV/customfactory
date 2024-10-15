<div class="modal-main">
            {set $imgPrefix = $_modx->config.file_prefix}
            <div class="modal-close" data-modal-close=""></div>
            <form data-si-form="modalProductStatus" data-si-nosave enctype="multipart/form-data" class="modal-area modal-content scrollbar">
                <input type="hidden" name="selected_id[]" value="{$id}">
                <div class="good-items">
                    {foreach $workflow as $item last=$l}
                        {if $l}
                            <div class="good-item">
                                <div class="columns">
                                    <div class="column col-6 md-col-12">
                                        <div class="good-images">
                                            {foreach ($item.preview | split: '|') as $img index=$i}
                                                <div class="good-image">
                                                    <div class="good-image__img">
                                                        <img src="{$imgPrefix}{$img}" alt="">
                                                    </div>
                                                    <div class="good-image__title">{$img}</div>
                                                </div>
                                            {/foreach}
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
                                                    <div class="good-image__title">$filename</div>
                                                </div>
                                            </template>
                                            <div class="good-images" style="width:100%;flex-wrap:wrap;" data-fu-dropzone>
                                                <div class="good-image">
                                                    <div class="good-image__add">
                                                        <span>Загрузите скриншоты</span>
                                                        <input data-fu-field multiple type="file" form="toRework" class="good-image__file">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="good-list">
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
                                                    <div class="good-report__date">{$item.designer_date}</div>
                                                    <div class="good-report__quote">
                                                        {$item.designer_comment}
                                                    </div>
                                                </div>
                                            {/if}

                                            <textarea class="input textarea" name="content" data-sync="#content" placeholder="Введите комментарий"></textarea>

                                            <div class="good-report">
                                                <div class="good-item__title">
                                                    Установить статус:
                                                </div>
                                                <div class="btn-group">
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
                                        <div class="good-images">
                                            {foreach ($item.preview | split: '|') as $img index=$i}
                                                <div class="good-image">
                                                    <div class="good-image__img">
                                                        <img src="{$imgPrefix}{$img}" alt="">
                                                    </div>
                                                    <div class="good-image__title">{$img}</div>
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
                        {/if}
                    {/foreach}
                </div>
            </form>
            {if $status in list [1,2]}
                <form id="toRework" data-si-form class="modal-footer center">
                    <input type="hidden" name="selected_id[]" value="{$id}">
                    <input type="hidden" name="status" value="7">
                    <input type="hidden" name="content" id="content" value="">
                    <button type="button" class="btn btn--small btn--line" data-si-preset="toRework" data-si-event="click">На доработку</button>
                </form>
            {/if}
        </div>
