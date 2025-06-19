<div id="{$id}">
    <div class="showcase-table">
        <table>
            <thead>
            <tr>
                <th>№ п.п.</th>
                <th>ФИО</th>
                <th>Номер ЛК</th>
                {set $offers = $_modx->runSnippet('@FILE snippets/designer/snippet.getoffers.php', [])}
                {foreach $offers as $offer}
                <th>Оферта №{$offer}</th>
                {/foreach}
            </tr>
            </thead>
            <tbody>##'pdoUsers' | snippet: [
                        'tpl' => '@FILE chunks/pdousers/offers/item.tpl',
'groups' => '2',
'limit' => '0',
'offers' => $offers,
]}</tbody>
        </table>
    </div>
</div>