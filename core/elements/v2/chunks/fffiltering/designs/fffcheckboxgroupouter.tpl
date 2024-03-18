<div class="filter-item">
                        <ul class="filter-list">
                            <li>
                                <div class="filter-name filter-name--select" data-popup-link="filter-{$key}">
                                    {('ff_frontend_'~$key) | lexicon}
                                </div>
                                <div class="popup-menu popup-menu--checked" data-popup="filter-{$key}">
                                    <ul class="filter-value-list scrollbar">
                                        {$options}
                                        
                                    </ul>
                                </div>
                            </li>
                        </ul>
                    </div>