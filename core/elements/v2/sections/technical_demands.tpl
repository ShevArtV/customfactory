<div class="offset-top offset-top--small">
    <div class="head">
        <div class="head-title">{$title}</div>
    </div>

    <div class="container-medium">

        <ul class="requirements-list">{foreach $list_double as $item1 index=$i last=$l}
                    <li>
                <h3>{$item1.title}</h3>
                <span>{$item1.content}</span>
            </li>{/foreach}
                    </ul>

    </div>

</div>