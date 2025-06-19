<div class="column {$idx < 4 ? 'col-4 md-col-12': 'col-6 md-col-12'}" data-mpc-rid="14">
                    <div class="item">
                        {$is_hit ? '<div class="item-label">Хит продаж</div>' : ''}
                        <div class="item-image" style="background-image:url({$img});"></div>
                        <div class="item-title">{$pagetitle}</div>
                        <div class="item-price">
                            Выплаты: <span>{$introtext}</span>
                        </div>
                    </div>
                </div>