<div id="{$id}" class="card">

    <div class="card-image">
        <img src="{$resource.tvs.img | pThumb: 'w=398&h=345&zc=1'}" alt="" width="398" height="345">
    </div>

    <div class="card-content">
        <h1>{$resource.pagetitle}</h1>

        <div class="card-price">
            Вознаграждение с продажи: <span class="red">{$resource.price} ₽</span>
        </div>

        <div class="btn-group">
            {if $resource.tvs.tplfile}
            <a href="{$resource.tvs.tplfile}" download class="btn">Скачать файл шаблона</a>
            {/if}
            ##set $allow_add = $_modx->getPlaceholder('user_allow_add')}
            <a href="{51982 | url}?parent={$resource.parent}&type={$resource.id}" class="btn btn--line ##!$allow_add ? 'disabled': ''}">Загрузить дизайн</a>
        </div>

    </div>

</div>