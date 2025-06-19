<tr>
                {set $offers = $_modx->runSnippet('@FILE snippets/designer/snippet.getoffers.php', [])}
                <td>{$idx}</td>
                <td>{$fullname}</td>
                <td>{$profile_num}</td>
                {foreach $offers as $offer}
                    <td>{$extended['offer'~$offer]?:'неизвестна'}</td>
                {/foreach}
            </tr>