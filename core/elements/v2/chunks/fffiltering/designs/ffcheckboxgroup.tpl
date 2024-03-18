<li>
                                            {if $key === 'status'}
                                                {set $statuses = ('statuses' | placeholder)}
                                            {/if}
                                            <label class="checkbox-label">
                                                {set $values = ($.get[$key] | split: ',') ?: []}
                                                {switch $key}
                                                {case 'parent'}
                                                {case 'root_id'}
                                                {set $caption = $value | resource: 'pagetitle'}
                                                {case 'status'}
                                                {set $caption = $statuses['product'][$value]['caption']}
                                                {default}
                                                {set $caption = $value}
                                                {/switch}
                                                <input class="checkbox" type="checkbox" data-ff-filter="{$key}" name="{$key}[]" data-ff-caption="{$caption}" value="{$value}" id="{$key}-{$idx}" {($value in list $values) ? 'checked' : ''}>
                                                <span class="checkbox-text checkbox-text--small">{$caption}</span>
                                            </label>
                                        </li>