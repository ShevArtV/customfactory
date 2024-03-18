<div id="{$id}">
    ##if !('user_allow_add' | placeholder)}
    <div class="page-layout offset-top offset-top--small">
        <div class="page-layout__content container-small">

            <h2>{$title}</h2>

            <div class="page">{$subtitle}</div>

            <div class="step-header">
                ##'user_total' | placeholder | declension : 'шаг|шага|шагов' : true} из 5 пройдено
                ##set $progress = $_modx->getPlaceholder('user_progress')}
                ##set $steps = $_modx->getPlaceholder('user_steps')}
                <div class="step-loading">
                    <span style="width: ##$progress}%;">##$progress}%</span>
                </div>

            </div>

            <ul class="step-list">{foreach $list_triple as $item1 index=$i last=$l}
                    <li class="##$steps.{$item1.subtitle} ? 'active' : ''}">
                    
                    <div class="step-list__title">{$item1.title}</div>
                    <div class="step-list__text">{$item1.content}</div>
                </li>{/foreach}
                    </ul>

            <div class="page">{$content}</div>
        </div>


        <div class="page-layout__aside">##'pdoResources' | snippet: [
                        'parents' => '51971',
'tpl' => '@FILE chunks/pdoresources/help_aside/item.tpl',
'resources' => '51972,51973,51974',
'includeTVs' => 'img',
'tvPrefix' => '',
'sortby' => '{ "menuindex":"ASC"}',
]}</div>
    </div>
    ##/if}
</div>