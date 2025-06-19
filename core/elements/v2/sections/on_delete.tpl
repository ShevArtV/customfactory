<div id="{$id}">

    <form id="fileForm" data-si-form class="filter filter--glass filter--no-margin">
        <div class="filter-column">
            <div class="filter-item">
                <div class="ondelfile" data-fu-wrap data-si-preset="upload_excel" data-si-nosave>
                    <input type="hidden" name="filelist" data-fu-list>
                    <div data-fu-progress=""></div>
                    <label class="file-form file-attachment" data-fu-dropzone>
                        <input type="file" name="files" data-fu-field multiple class="v_hidden" placeholder="Выберите файл">
                        <span data-fu-hide class="file-form__text">Перетащите сюда файл</span>
                    </label>
                    <template data-fu-tpl>
                        <button type="button" class="btn file-list__btn" data-fu-path="$path">$filename x</button>
                    </template>
                </div>
            </div>
        </div>
        <div class="filter-column">
            <div class="filter-item">
                <div class="btn-group">
                    <button type="button" class="btn btn--small" data-si-event="click" data-si-preset="getfilesproducts">Сгенерировать</button>
                    <div class="btn-info">
                        Нажмите, чтобы создать список <br>
                        товаров на удаление
                    </div>
                </div>
            </div>
        </div>
    </form>

    <!--filter-->
    <form data-si-form="listActionProducts" id="listActionProducts" data-si-nosave class="filter filter--glass filter--border-top" data-del-statuses>
        <div class="filter-column">
            <ul class="filter-list">
                <li>
                    <div class="btn-group">
                        <div class="filter-item">
                            <label class="checkbox-label">
                                <input type="checkbox" class="checkbox" data-select-all>
                                <span class="checkbox-text">Выбрать все</span>
                            </label>
                        </div>
                        <div class="filter-item">
                            <button type="button" class="btn btn--line btn--small" data-unselect-all>Очистить выбор</button>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="btn-group">
                        <div class="filter-item">
                            <div class="js-custom-select select-pill">
                                {set $statuses = ('statuses' | placeholder)}
                                <select class="" data-list-status="5" name="status">
                                    {foreach $statuses['product'] as $id => $data}
                                        {if $id !== 7}
                                            <option value="{$id}">{$data.caption}</option>
                                        {/if}
                                    {/foreach}
                                </select>
                            </div>
                        </div>
                        <div class="filter-item">
                            <button type="button" class="btn btn--dark btn--small" data-si-event="click" data-si-preset="changeStatus">Установить статус</button>
                        </div>
                        <div class="filter-item">
                            Всего дизайнов: <span data-pn-total-results>0</span>
                        </div>
                    </div>
                </li>
            </ul>
        </div>

        <div id="modal-comment" aria-hidden="true" class="modal modal-main_sm">
            <div class="modal-main">
                <div class="modal-close" data-modal-close></div>
                <div class="modal-content">
                    <div class="designer-card__content">
                        <h3>Причина отказа:</h3>
                        <textarea class="input textarea" name="content" placeholder="Если дизайн не прошёл модерацию, обязательно укажите причину"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="filter-column">
            <div class="btn-group">
                <button class="btn btn--small" type="button" form="listActionProducts" data-si-event="click" data-si-preset="changeDeleted">Удалить</button>
            </div>
        </div>
    </form>

    <div class="columns" data-results="on_delete">
        
    </div>

    <div data-pn-pagination class="d-flex justify-content-between {$totalPages < 2 ? 'd-none' : ''}" style="gap:20px;flex-wrap:wrap;margin-top:60px;">
        <div class="pagination">
            <button type="button" class="toggler start" data-pn-first="1"></button>
            <button type="button" class="toggler prev" data-pn-prev></button>
            <input type="number" name="page" data-pn-current form="fileForm" data-si-preset="getfilesproducts" min="1" max="{$totalPages}" value="{$.get.page?:1}">
            <span data-pn-total>{$totalPages}</span>
            <button type="button" class="toggler next" data-pn-next></button>
            <button type="button" class="toggler end" data-pn-last="{$totalPages}"></button>
        </div>
        <input type="number" name="limit" min="6" max="102" data-pn-limit form="fileForm" data-si-preset="getfilesproducts" value="30">
    </div>
</div>