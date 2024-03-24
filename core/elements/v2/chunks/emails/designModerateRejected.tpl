<p>Ваш дизайн <em><strong>{$pagetitle}</strong></em> не прошёл модерацию по следующим причинам:</p>
<p><em><strong>{$reasons}</strong></em></p>

{if $preview}
    {foreach $preview as $path}
    <img src="{$filePrefix}{$path}" width="249" height="281" alt="">
{/if}

<p>Для обжалования обратитесь в техническую поддержку <a href="mailto:support@customfactory.ru">support@customfactory.ru</a></p>