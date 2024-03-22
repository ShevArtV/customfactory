{extends 'file:sections/wrapper.tpl'}
{block 'content'}
    {set $path = '!getParsedConfigPath' | snippet:[]}
    {if $path}
        {include $path}
    {else}
        <div class="showcase">
            <div class="container">
                {$_modx->resource.content}
            </div>
        </div>
    {/if}
{/block}