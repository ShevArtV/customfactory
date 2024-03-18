<div>
            <form id="filterForm" class="filter" action="#" data-ff-form="filterForm">
                <input type="hidden" name="configId" value="{$configId}">
                <input type="hidden" name="configId" form="generateReport" value="{$configId}">
                <div class="filter-column">
                    <div class="filter-item">
                        <div class="filter-name">Дизайнеров: <span id="total">{$totalResources?:0}</span>
</div>
                    </div>
                    {$filters}
                    

                    

                    

                    
                </div>
                <div class="filter-column">
                    <div class="filter-item">
                        <div class="filter-name" data-modal-show="#modal-excel">Скачать в Excel</div>
                    </div>
                    <div class="filter-item filter-item--search">
                        <button type="button" class="filter-search" data-modal-show="#modal-search"></button>
                    </div>
                </div>
            </form>

            <form data-si-form="listActionUsers" id="listActionUsers" data-si-nosave class="filter filter--glass">
                <div class="filter-column">
                    <ul class="filter-list">
                        <li>
                            <div class="btn-group">
                                <div class="filter-item">
                                    <label class="checkbox-label">
                                        <input type="checkbox" data-select-all class="checkbox">
                                        <span class="checkbox-text">Выбрать все</span>
                                    </label>
                                </div>
                                <div class="filter-item">
                                    <button class="btn btn--line btn--small" type="button" data-unselect-all>Очистить выбор</button>
                                </div>
                            </div>
                        </li>
                        <li>
                            <div class="btn-group">
                                <div class="filter-item">
                                    <div class="js-custom-select select-pill">
                                        {set $statuses = ('statuses' | placeholder)}
                                        <select class="" data-listuser-status name="status">
                                            {foreach $statuses['designer'] as $id => $data}
                                                <option value="{$id}">{$data.caption}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                <div class="filter-item">
                                    <button class="btn btn--dark btn--small" type="button" data-si-event="click" data-si-preset="setStatusUsers">Установить статус</button>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="filter-column">
                    <div class="btn-group">
                        <button class="btn btn--small" type="button" data-si-event="click" data-si-preset="removeUsers">Удалить выбранные</button>
                    </div>
                </div>
                <div id="modal-comment" aria-hidden="true" class="modal modal-main_sm">
                    <div class="modal-main">
                        <div class="modal-close" data-modal-close></div>
                        <div class="modal-content">
                            <div class="designer-card__content">
                                <h3>Причина отказа:</h3>
                                <textarea class="input textarea" name="comment" placeholder="Если дизайнер не прошёл модерацию, обязательно укажите причину"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </form>

            <div class="designer-items" data-ff-results>
                {$resources}
                
            </div>

            <div class="d-flex justify-content-between">
                <div data-pn-pagination class="pagination {$totalPages < 2 ? 'd-none' : ''}">
                    <button type="button" class="toggler start" data-pn-first="1"></button>
                    <button type="button" class="toggler prev" data-pn-prev></button>
                    <input type="number" name="page" data-pn-current form="filterForm" min="1" max="{$totalPages}" value="{$.get.page?:1}">

                    <span data-pn-total>{$totalPages}</span>
                    <button type="button" class="toggler next" data-pn-next></button>
                    <button type="button" class="toggler end" data-pn-last="{$totalPages}"></button>
                </div>
                <label>
                    <span>Показывать по:</span>
                    <input type="number" name="limit" data-pn-limit form="filterForm" class="red-input" min="1" value="{$limit}">
                </label>
            </div>

            <div id="modal-excel" aria-hidden="true" class="modal">
                <form id="generateReport" data-si-form="generateReport" data-si-nosave class="modal-main">
                    <div class="modal-close" data-modal-close></div>
                    <div class="modal-content scrollbar">
                        <h2>Выберите данные для отображения в файле.</h2>
                        <div class="columns-list columns-list-2">
                            <input type="hidden" name="className" value="modUser">
                            {set $groups = $_modx->runSnippet('@FILE snippets/designer/snippet.getuserfields.php', [])}
                            {foreach $groups as $group => $fields}
                                <div class="columns-list__item">
                                    <div class="columns-list__letter">{$group}</div>
                                    {foreach $fields as $key => $caption}
                                        <div class="columns-list__name">
                                            <input type="checkbox" name="captions[{$key}][]" data-caption="{$key}" value="{$caption}" class="v_hidden">
                                            <label class="checkbox-label">
                                                <input type="checkbox" name="names[]" value="{$key}" data-key="{$key}" class="checkbox">
                                                <span class="checkbox-text">{$caption}</span>
                                            </label>
                                        </div>
                                    {/foreach}
                                </div>
                            {/foreach}
                        </div>
                    </div>
                    <div class="modal-footer center">
                        <button type="button" class="btn" data-si-event="click" data-si-preset="generate_report">Скачать</button>
                    </div>
                </form>
            </div>

            {include "file:chunks/common/search_modal.tpl"}
        </div>