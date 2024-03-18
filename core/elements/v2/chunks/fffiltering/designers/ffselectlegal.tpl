<div class="filter-item">
                        <div class="d-flex align-items-center column-gap-10">
                            <label class="">Правовая форма:</label>
                            <div class="js-custom-select">
                                <select class="" data-ff-filter="{$key}" name="{$key}">
                                    <option value="" {!$.get[$key] ? 'selected' : ''}>Любая</option>
                                    {$options}
                                    
                                </select>
                            </div>
                        </div>
                    </div>