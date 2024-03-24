<!--##{"templatename":"Оферты и дизайнеры","pagetitle":"Страница Оферты и дизайнеры","icon":"icon-eye","extends":"12"}##-->

<!-- /usr/local/php/php-7.4/bin/php /home/host1860015/art-sites.ru/htdocs/customfactory/core/components/migxpageconfigurator/console/mgr_tpl.php web designers_offers.tpl -->

<div id="{$id}" data-mpc-section="designers_offers" data-mpc-name="Оферты и дизайнеры">
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
            <tbody data-mpc-snippet="pdoUsers|offers">
            <tr data-mpc-chunk="pdousers/offers/item.tpl">
                {set $offers = $_modx->runSnippet('@FILE snippets/designer/snippet.getoffers.php', [])}
                <td>{$idx}</td>
                <td>{$fullname}</td>
                <td>{$profile_num}</td>
                {foreach $offers as $offer}
                    <td>{$extended['offer'~$offer]?:'неизвестна'}</td>
                {/foreach}
            </tr>
            </tbody>
        </table>
    </div>
</div>