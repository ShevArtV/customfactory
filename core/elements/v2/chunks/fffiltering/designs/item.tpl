<div class="column col-4 md-col-6 sm-col-12" id="product-{$id}">
                    {if $status == 1 || ($prev_status == 1 && $status == 7)}
                        {set $class = 'product--new'}
                    {elseif $status == 2 || ($prev_status == 2 && $status == 7)}
                        {set $class = 'product--check'}
                    {elseif $status == 3}
                        {set $class = 'product--article'}
                    {elseif $status == 4}
                        {set $class = 'product--sale'}
                    {elseif $status == 5 || $status == 6}
                        {set $class = 'product--cancel'}
                    {elseif $status == 7}
                        {set $class = 'product--check'}
                    {/if}
                    <div class="card-design {$class}">
                        <div class="card-design__check">
                            <label class="checkbox-label">
                                <input type="checkbox" class="checkbox" name="selected_id[]" id="sel-product-{$id}" value="{$id}" form="listActionProducts">
                                <span class="checkbox-text"></span>
                            </label>
                        </div>
                        {if $status == 7}
                            <div class="product-label btn btn--small">На доработку</div>
                        {/if}

                        <ul class="card-design__images" {if $status == 5} data-modal-show='reject-{$id}' {/if} {if ($status in list [1,2,7])}data-load-workflow='{$id}'{/if} style="cursor: pointer;">
                            {set $previews = $preview | split: '|'}
                            {if $previews}
                                {foreach $previews as $path}
                                    <li style="background-image: url({$_modx->config.file_prefix}{$path}); background-size: cover; background-position: center;">
                                {/foreach}
                            {/if}
                        </li>
</ul>
                        {if $previews}
                        <form data-si-form data-si-preset="remove_preview">
                            <input type="hidden" name="id" value="{$id}">
                            <button style="text-decoration: underline;background: none;border:none;color:var(--color-link)">Перегенерировать превью</button>
                        </form>
                        {/if}
                        <div class="card-design__content">
                            <div class="card-design__title" {if ($status in list [1,2,7])}data-load-workflow='{$id}'{/if} style="cursor: pointer;">{$designer}</div>
                            <ul class="card-design__params">
                                <li>Номер ЛК: {$profilenum?:'Не задан'}</li>
                                <li>Создан {$createdon | date: 'd.m.Y H:i'}</li>
                            </ul>
                        </div>
                        <div class="card-design__footer">
                            <ul class="card-design__params">
                                <li class="active">
                                    Статус: {$statuses['product'][$status]['caption']}
                                </li>
                                <li>
                                    Категория: <a href="#" data-modal-show="#modal-parent-{$id}" data-for="#sel-product-{$id}" style="text-decoration: underline;">{$parent ? $categories[$parent] : 'Не задана'}</a>
                                </li>
                                <li>
                                    Тип товара: <a href="#" data-modal-show="#modal-root-{$id}" data-for="#sel-product-{$id}" style="text-decoration: underline;">{$root_id ? $types[$root_id] : 'Не задан'}</a>
                                </li>
                                <li>
                                    Тэг: <a href="#" data-modal-show="#modal-tag-{$id}" data-for="#sel-product-{$id}" style="text-decoration: underline;">{$tags[0]?:'Назначить тэг'}</a>
                                </li>
                                <li>Цвета:
                                    {foreach $color as $c last=$l}
                                        <a href="#" data-modal-show="#modal-color-{$id}" data-for="#sel-product-{$id}" style="text-decoration: underline;">{$c}</a>{if !$l},{/if}
                                    {/foreach}
                                </li>
                            </ul>
                            <div style="padding-top:20px" class="product-articles">
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
                            <div class="good-list">
                                {set $imgPrefix = $_modx->config.file_prefix}
                                <ul class="good-list__files" style="margin-top: 10px;">
                                    {foreach ($print | split: '|') as $img index=$i}
                                        <li><a href="{$imgPrefix}{$img}" download target="_blank" style="text-decoration: underline;">Печатный файл №{$i+1}</a></li>
                                    {/foreach}
                                </ul>
                            </div>
                        </div>

                        <div id="modal-parent-{$id}" aria-hidden="true" class="modal">
                            <div class="modal-main">
                                <div class="modal-close" data-modal-close></div>
                                <div class="modal-title">Выберите категорию</div>
                                <div class="modal-content scrollbar">
                                    {if $categories}
                                        <div class="columns-list">
                                            {foreach $categories as $rid => $title}
                                                <div class="columns-list__name">
                                                    <label class="checkbox-label">
                                                        <input type="radio" value="{$rid}" class="checkbox" name="data[{$id}][parent]" {$rid === $parent ? 'checked' : ''} form="listActionProducts">
                                                        <span class="checkbox-text">{$title}</span>
                                                    </label>
                                                </div>
                                            {/foreach}
                                        </div>
                                    {/if}
                                </div>
                                <div class="modal-footer center">
                                    <button type="button" class="btn" form="listActionProducts" data-si-event="click" data-si-preset="changeParent">Сохранить</button>
                                </div>
                            </div>
                        </div>

                        <div id="modal-root-{$id}" aria-hidden="true" class="modal">
                            <div class="modal-main">
                                <div class="modal-close" data-modal-close></div>
                                <div class="modal-title">Выберите тип товара</div>
                                <div class="modal-content scrollbar">
                                    {if $types}
                                        <div class="columns-list">
                                            {foreach $types as $rid => $title}
                                                <div class="columns-list__name">
                                                    <label class="checkbox-label">
                                                        <input type="radio" value="{$rid }" class="checkbox" name="data[{$id}][root_id]" {$rid  === $root_id ? 'checked' : ''} form="listActionProducts">
                                                        <span class="checkbox-text">{$title}</span>
                                                    </label>
                                                </div>
                                            {/foreach}
                                        </div>
                                    {/if}
                                </div>
                                <div class="modal-footer center">
                                    <button type="button" class="btn" form="listActionProducts" data-si-event="click" data-si-preset="changeRootId">Сохранить</button>
                                </div>
                            </div>
                        </div>

                        <div id="modal-tag-{$id}" aria-hidden="true" class="modal">
                            <input type="hidden" value="{$tag_label}" form="listActionProducts" name="data[{$id}][tags][]">
                            <div class="modal-main">
                                <div class="modal-close" data-modal-close></div>
                                <div class="modal-title">Назначьте тэг для дизайна</div>
                                <div class="search">
                                    <input type="text" class="input search-input" name="query" data-si-preset="search_tag" data-si-event="input" placeholder="введите тэг">
                                </div>
                                <div class="modal-content scrollbar">
                                    <div class="columns-list" data-checkbox-wrap>
                                        {foreach $allTags as $char => $items}
                                            <div class="columns-list__item">
                                                <div class="columns-list__letter">{$char | replace: 'A_' : ''}</div>
                                                {foreach $items as $tag_id => $tag_name}
                                                    <div class="columns-list__name">
                                                        <label class="checkbox-label">
                                                            <input type="radio" name="data[{$id}][tag_label]" data-tag="data[{$id}][tags][]" data-checkbox="{$tag_name}" value="{$tag_id}" {$tags[0] == $tag_name ? 'checked' : '' } form="listActionProducts" class="checkbox">
                                                            <span class="checkbox-text">{$tag_name}</span>
                                                        </label>
                                                    </div>
                                                {/foreach}
                                            </div>
                                        {/foreach}
                                    </div>
                                </div>
                                <div class="modal-footer center">
                                    <button type="button" class="btn" form="listActionProducts" data-si-event="click" data-si-preset="changeTags">Сохранить</button>
                                </div>
                            </div>
                        </div>

                        <div id="modal-color-{$id}" aria-hidden="true" class="modal">
                            <div class="modal-main">
                                <div class="modal-close" data-modal-close></div>
                                <div class="modal-title">Выберите цвета</div>
                                <div class="modal-content scrollbar">
                                    {if $colors}
                                        <div class="columns-list">
                                            {foreach $colors as $c}
                                                <div class="columns-list__name">
                                                    <label class="checkbox-label">
                                                        <input type="checkbox" value="{$c | strip}" class="checkbox" name="data[{$id}][color][]" data-color {(($c | strip) in list $color) ? 'checked' : ''} form="listActionProducts" data-checkbox="{$c | strip}">
                                                        <span class="checkbox-text">{$c | strip}</span>
                                                    </label>
                                                </div>
                                            {/foreach}
                                        </div>
                                    {/if}
                                </div>
                                <div class="modal-footer center">
                                    <button type="button" class="btn" form="listActionProducts" data-si-event="click" data-si-preset="changeColor">Сохранить</button>
                                </div>
                            </div>
                        </div>

                        {if $status == 7}
                            <div id="modal-moderation-{$id}" aria-hidden="false" class="modal">
                                <div class="modal-main">
                                    <div class="modal-close" data-modal-close></div>
                                    <div class="modal-title">На модерации</div>
                                    <div class="modal-content scrollbar">
                                        <div class="good-items">
                                            <div class="good-item">
                                                <div class="columns">
                                                    <div class="column col-6 md-col-12">
                                                        <ul class="good-item__params">
                                                            <li>Товар: {$types[$root_id]}</li>
                                                            <li style="display:flex;gap:5px;align-items:center;">
                                                                <span class="good-item__status status--check"></span>
                                                                На модерации
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
                                            <div class="good-item">
                                                <div class="columns">
                                                    <div class="column col-12">
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
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {/if}

                    </div>
                </div>