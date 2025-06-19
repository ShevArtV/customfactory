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

    {if $resource.tvs.offers_history}
        <h3 style="margin-top:50px;margin-bottom:25px;">История оферт</h3>
        <ul>
            {foreach ($resource.tvs.offers_history | fromJSON) as $item}
                <li>
                    <a href="#" data-modal-show="offer-{$item['id']}">Оферта №{$item['id']}</a>
                    <div id="offer-{$item['id']}" aria-hidden="true" class="modal">
                        <div class="modal-main">
                            <div class="modal-close" data-modal-close></div>
                            <div class="modal-content scrollbar">
                                {$item['text']}
                            </div>
                        </div>
                    </div>
                </li>
            {/foreach}
        </ul>
    {/if}
</div>