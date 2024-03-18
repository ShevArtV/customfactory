<div id="{$id}">
    <div class="text-block">
        {$resource.content}
    </div>

    ##if !$_modx->user.extended['offer{$resource.introtext}']}
    <form method="post" data-si-form="acceptForm" data-si-preset="acceptoffer">
        <label class="checkbox-label form-check">
            <input type="checkbox" class="checkbox" name="extended[offer]" id="offer" value="Да">
            <span class="checkbox-text" for="offer">Я принимаю договор оферты</span>
        </label>
        <input type="hidden" name="extended[offer{$resource.introtext}]" value="{'' | date: 'd.m.Y H:i'}">
        <button type="submit" class="btn btn-primary">Принять</button>
    </form>
    ##else}
    <p class="offer-accept">Вы уже приняли эту оферту.</p>
    ##/if}
</div>