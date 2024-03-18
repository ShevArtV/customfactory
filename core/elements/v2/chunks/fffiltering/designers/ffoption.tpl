
                                        {set $statuses = ('statuses' | placeholder)}
                                        <option value="{$value}" {($value == $.get[$key]) ? 'selected' : ''}>{$statuses.designer[$value].caption}</option>
                                    