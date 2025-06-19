<div class="column col-4 md-col-6 sm-col-12">
            <div class="card-design">
                <div class="card-design__check">
                    <label class="checkbox-label">
                        <input type="checkbox" class="checkbox" name="selected_id[]" id="sel-product-{$id}" value="{$id}" form="listActionProducts">
                        <span class="checkbox-text"></span>
                    </label>
                </div>

                <ul class="card-design__images">
                    {set $previews = $preview | split: '|'}
                    {if $previews}
                        {foreach $previews as $path}
                            <li style="background-image: url({$_modx->config.file_prefix}{$path})">
                        {/foreach}
                    {/if}
                </li>
</ul>
                <div class="card-design__content">
                    <div class="card-design__title">{$pagetitle}</div>
                </div>
                <div class="card-design__footer">
                    <ul class="card-design__params">
                        <li>Категория: {$parent ? $categories[$parent] : 'Не задана'}</li>
                        <li class="active">Статус: {$statuses['product'][$status]['caption']}</li>
                        <li>Номер ЛК: {$profilenum?:'Не задан'} ({$createdby})</li>
                    </ul>
                </div>
            </div>
        </div>