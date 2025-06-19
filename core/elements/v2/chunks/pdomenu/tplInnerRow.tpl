<li class="{(!$_modx->user.extended['offer'] && $parent == 51978) ? 'disabled' : ''}{(!('user_allow_add' | placeholder) && $parent == 12) ? 'disabled' : ''}">
                                    {set $week = '' | period: 'week'}
                                    <a href="{$uri}{$id == 54752 ? '?date='~$week : ''}" {($class_key == 'modWebLink' ? 'target=_blank' : '')}>
                                        {$pagetitle}
                                        {if $id == 54748 && $_modx->user.extended['rework']}
                                            <span class="good-item__status status--cancel"></span>
                                        {/if}
                                    </a>
                                </li>