<div id="{$id}">
    ##if ('user_allow_add' | placeholder)}
    <div class="offset-top offset-top--small container-medium">
        <div class="input-group">
            <a href="{$target | resource: 'uri'}" class="btn">
                <span>{$btn_text}</span>
            </a>
        </div>
        <div class="page">{$content}</div>
    </div>

    ##'msProducts' | snippet: []}
    {if $popular}
        <div class="offset-top">
            <h2>{$title}</h2>

            <div class="columns">
                {$popular}
                
            </div>

        </div>
    {/if}
    ##/if}
</div>