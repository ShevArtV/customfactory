<div class="container-medium" id="load_design_text_1707850229185">
    <div class="page">Загрузите файлы с дизайном товара, который вы сделали, в сервис.
        Мы принимаем 2 файла: мокап в интерьере и файл для печати.
        Проверьте ещё раз соответствуют ли они <a href="">техническим требованиям</a>.
        <br>
        <br>
        Модератор проверит файлы и отправит их на маркетплейсы.
        Убедитесь, что вы прочитали наши <a href="">Условия использования</a> и
        <a href="">Правила допустимого содержания</a>.</div>
</div><div class="offset-top">
    <form method="post" enctype="multipart/form-data" data-si-form="uploadQuizForm" data-si-preset="upload_quiz" data-si-nosave>
        <ul class="timeline md-hidden">
            <li data-qf-step="1" class="active">Товар</li>
            <li data-qf-step="2" class="">Файл</li>
            <li data-qf-step="3" class="">Тэг</li>
            <li data-qf-step="4" class="">Цвета</li>
            <li data-qf-step="5" class="">Комментарий</li>
        </ul>

        <!--Товар-->
        <div data-qf-item="1" class="timeline-pane container-small">

            <h3 class="md-visible">Товар</h3>

            <div class="blockquote">
                Выберите из списка тип товара, который хотите загрузить и укажите размер
            </div>

            <table class="type-table">
                <thead>
                <tr>
                    <th>Укажите тип товара</th>
                    <th>Укажите размер</th>
                </tr>
                </thead>
                <tbody>
                                                                            <tr>
                            <td>
                                <label class="type-table__link">
                                    <input type="radio" name="parent" value="14" data-size-target="#sizes-14">
                                    <span>Декоративные подушки</span>
                                </label>
                            </td>
                            <td>
                                <select class="type-table__select" disabled id="sizes-14">
                                                                            <option value="1">40x40</option>
                                                                            <option value="3">50x50</option>
                                                                            <option value="3">Набор 40x40</option>
                                                                    </select>
                            </td>
                        </tr>
                                            <tr>
                            <td>
                                <label class="type-table__link">
                                    <input type="radio" name="parent" value="15" data-size-target="#sizes-15">
                                    <span>Интерьерные картины</span>
                                </label>
                            </td>
                            <td>
                                <select class="type-table__select" disabled id="sizes-15">
                                                                            <option value="1">30x40</option>
                                                                            <option value="3">Набор 30x40</option>
                                                                            <option value="6">Набор из 6 картин 30х30 и 30х40 см</option>
                                                                            <option value="1">40x30</option>
                                                                            <option value="1">40x60</option>
                                                                            <option value="1">60x40</option>
                                                                            <option value="1">60x80</option>
                                                                            <option value="1">80x60</option>
                                                                    </select>
                            </td>
                        </tr>
                                            <tr>
                            <td>
                                <label class="type-table__link">
                                    <input type="radio" name="parent" value="17" data-size-target="#sizes-17">
                                    <span>Фотообои</span>
                                </label>
                            </td>
                            <td>
                                <select class="type-table__select" disabled id="sizes-17">
                                                                            <option value="1">1010х2800</option>
                                                                            <option value="1">2010х2800</option>
                                                                            <option value="1">3010х2800</option>
                                                                            <option value="1">4010х2800</option>
                                                                    </select>
                            </td>
                        </tr>
                                            <tr>
                            <td>
                                <label class="type-table__link">
                                    <input type="radio" name="parent" value="16" data-size-target="#sizes-16">
                                    <span>Дорожки</span>
                                </label>
                            </td>
                            <td>
                                <select class="type-table__select" disabled id="sizes-16">
                                                                            <option value="1">40x180</option>
                                                                    </select>
                            </td>
                        </tr>
                                            <tr>
                            <td>
                                <label class="type-table__link">
                                    <input type="radio" name="parent" value="18" data-size-target="#sizes-18">
                                    <span>Постеры</span>
                                </label>
                            </td>
                            <td>
                                <select class="type-table__select" disabled id="sizes-18">
                                                                            <option value="3">30x40</option>
                                                                    </select>
                            </td>
                        </tr>
                                                    </tbody>
            </table>

        </div>

        <!--Файл-->
        <div data-qf-item="2" class="timeline-pane container-small v_hidden" data-si-form="uploadDesignForm">

            <h3 class="md-visible">Файл</h3>

            <div class="blockquote">
                Приложите файл(ы) для печати (до 2гб каждый, имя файла может содержать только строчные и
                заглавные латинские буквы, цифры, тире и нижнее подчёркивание)
            </div>

            <h3>Приложите файл для печати</h3>

            <div data-fu-wrap data-si-preset="upload_design" data-si-nosave>
                <input type="hidden" name="filelist" data-fu-list>
                <div data-fu-progress=""></div>
                <label class="file-form file-attachment" data-fu-dropzone>
                    <input type="file" name="files" data-fu-field multiple class="v_hidden" placeholder="Выберите файл">
                    <span data-fu-hide class="file-form__text">Перетащите сюда файлы</span>
                </label>
                <template data-fu-tpl>
                    <button type="button" class="btn file-list__btn" data-fu-path="$path">$filename x</button>
                </template>
            </div>
        </div>

        <!--Тэг-->
        <div data-qf-item="3" class="timeline-pane container-small v_hidden">
            <input type="hidden" name="tags">
            <h3 class="md-visible">Тэг</h3>

            <div class="blockquote">
                Нажмите кнопку и выберите тэг, который описывает ваш дизайн
            </div>

            <div class="btn-group" data-checkbox-results>
                <button type="button" data-micromodal-trigger="modal-tag" class="btn btn--line btn--small">
                    Назначьте тэги
                </button>

                <template data-checkbox-tpl>
                    <button type="button" data-checkbox-value="$id" class="btn btn--line btn--small btn--tag">
                        $name
                    </button>
                </template>

            </div>

            <div id="modal-tag" aria-hidden="true" class="modal">
                <div data-micromodal-close class="modal-overlay">
                    <div class="modal-main">
                        <div class="modal-close" data-micromodal-close></div>
                        <div class="modal-title">Назначьте тэг для дизайна</div>
                        <div class="search">
                            <input type="text" class="input search-input" name="query" data-si-preset="search_tag" data-si-event="input" placeholder="введите тэг">
                        </div>
                        <div class="modal-content scrollbar">
                            <div class="columns-list" data-checkbox-wrap><div class="columns-list__item">
                                    <div class="columns-list__letter">Цифры</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="25" data-checkbox="23 февраля" class="checkbox">
                                            <span class="checkbox-text">23 февраля</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="26" data-checkbox="8 марта" class="checkbox">
                                            <span class="checkbox-text">8 марта</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="142" data-checkbox="3d животные" class="checkbox">
                                            <span class="checkbox-text">3d животные</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="144" data-checkbox="3d цветы и растения" class="checkbox">
                                            <span class="checkbox-text">3d цветы и растения</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="145" data-checkbox="3d листья" class="checkbox">
                                            <span class="checkbox-text">3d листья</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="146" data-checkbox="3d город" class="checkbox">
                                            <span class="checkbox-text">3d город</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="147" data-checkbox="3d природа" class="checkbox">
                                            <span class="checkbox-text">3d природа</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="148" data-checkbox="3d абстракция" class="checkbox">
                                            <span class="checkbox-text">3d абстракция</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="149" data-checkbox="3d космос" class="checkbox">
                                            <span class="checkbox-text">3d космос</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="150" data-checkbox="3d карта" class="checkbox">
                                            <span class="checkbox-text">3d карта</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="155" data-checkbox="3d геометрия" class="checkbox">
                                            <span class="checkbox-text">3d геометрия</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="177" data-checkbox="3d барельеф" class="checkbox">
                                            <span class="checkbox-text">3d барельеф</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">А</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="81" data-checkbox="Апельсин" class="checkbox">
                                            <span class="checkbox-text">Апельсин</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="109" data-checkbox="Абстракция" class="checkbox">
                                            <span class="checkbox-text">Абстракция</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="110" data-checkbox="Аниме" class="checkbox">
                                            <span class="checkbox-text">Аниме</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="159" data-checkbox="Авокадо" class="checkbox">
                                            <span class="checkbox-text">Авокадо</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">Б</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="55" data-checkbox="Бабочки" class="checkbox">
                                            <span class="checkbox-text">Бабочки</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="60" data-checkbox="Буквы" class="checkbox">
                                            <span class="checkbox-text">Буквы</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="86" data-checkbox="Бамбук" class="checkbox">
                                            <span class="checkbox-text">Бамбук</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="126" data-checkbox="Бетон" class="checkbox">
                                            <span class="checkbox-text">Бетон</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">В</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="30" data-checkbox="Внуку и внучке" class="checkbox">
                                            <span class="checkbox-text">Внуку и внучке</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="99" data-checkbox="Волны" class="checkbox">
                                            <span class="checkbox-text">Волны</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="131" data-checkbox="Воздушные шары" class="checkbox">
                                            <span class="checkbox-text">Воздушные шары</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="135" data-checkbox="Вино" class="checkbox">
                                            <span class="checkbox-text">Вино</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="153" data-checkbox="Винтаж" class="checkbox">
                                            <span class="checkbox-text">Винтаж</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">Г</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="44" data-checkbox="Гусь" class="checkbox">
                                            <span class="checkbox-text">Гусь</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="78" data-checkbox="Гранат" class="checkbox">
                                            <span class="checkbox-text">Гранат</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="92" data-checkbox="Грибы" class="checkbox">
                                            <span class="checkbox-text">Грибы</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="107" data-checkbox="Геометрия" class="checkbox">
                                            <span class="checkbox-text">Геометрия</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="119" data-checkbox="Город" class="checkbox">
                                            <span class="checkbox-text">Город</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="167" data-checkbox="Горы" class="checkbox">
                                            <span class="checkbox-text">Горы</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="176" data-checkbox="Граффити" class="checkbox">
                                            <span class="checkbox-text">Граффити</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">Д</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="28" data-checkbox="День рождения" class="checkbox">
                                            <span class="checkbox-text">День рождения</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="29" data-checkbox="Дочке и сыну" class="checkbox">
                                            <span class="checkbox-text">Дочке и сыну</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="31" data-checkbox="Дедушке и бабушке" class="checkbox">
                                            <span class="checkbox-text">Дедушке и бабушке</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="32" data-checkbox="Дяде и тёте" class="checkbox">
                                            <span class="checkbox-text">Дяде и тёте</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="38" data-checkbox="Динозавры" class="checkbox">
                                            <span class="checkbox-text">Динозавры</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="24" data-checkbox="Дизайнерский принт" class="checkbox">
                                            <span class="checkbox-text">Дизайнерский принт</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="84" data-checkbox="Деревья" class="checkbox">
                                            <span class="checkbox-text">Деревья</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="93" data-checkbox="Дача" class="checkbox">
                                            <span class="checkbox-text">Дача</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="95" data-checkbox="Дом" class="checkbox">
                                            <span class="checkbox-text">Дом</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="156" data-checkbox="Дракон" class="checkbox">
                                            <span class="checkbox-text">Дракон</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="163" data-checkbox="Десерты" class="checkbox">
                                            <span class="checkbox-text">Десерты</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="170" data-checkbox="Девушка" class="checkbox">
                                            <span class="checkbox-text">Девушка</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="172" data-checkbox="Детские" class="checkbox">
                                            <span class="checkbox-text">Детские</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">Е</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="37" data-checkbox="Единороги" class="checkbox">
                                            <span class="checkbox-text">Единороги</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="136" data-checkbox="Еда" class="checkbox">
                                            <span class="checkbox-text">Еда</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">Ж</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="33" data-checkbox="Жене" class="checkbox">
                                            <span class="checkbox-text">Жене</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="36" data-checkbox="Животные" class="checkbox">
                                            <span class="checkbox-text">Животные</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="133" data-checkbox="Железная дорога" class="checkbox">
                                            <span class="checkbox-text">Железная дорога</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">З</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="61" data-checkbox="Знак зодиака" class="checkbox">
                                            <span class="checkbox-text">Знак зодиака</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="139" data-checkbox="Звезды" class="checkbox">
                                            <span class="checkbox-text">Звезды</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="175" data-checkbox="Заяц" class="checkbox">
                                            <span class="checkbox-text">Заяц</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">И</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="58" data-checkbox="Имена" class="checkbox">
                                            <span class="checkbox-text">Имена</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="82" data-checkbox="Ирисы" class="checkbox">
                                            <span class="checkbox-text">Ирисы</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">К</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="40" data-checkbox="Кот" class="checkbox">
                                            <span class="checkbox-text">Кот</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="41" data-checkbox="Крёстной и крёстному" class="checkbox">
                                            <span class="checkbox-text">Крёстной и крёстному</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="85" data-checkbox="Клубника" class="checkbox">
                                            <span class="checkbox-text">Клубника</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="105" data-checkbox="Каллиграфия" class="checkbox">
                                            <span class="checkbox-text">Каллиграфия</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="116" data-checkbox="Карта" class="checkbox">
                                            <span class="checkbox-text">Карта</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="120" data-checkbox="Кирпич" class="checkbox">
                                            <span class="checkbox-text">Кирпич</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="121" data-checkbox="Кофе" class="checkbox">
                                            <span class="checkbox-text">Кофе</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="123" data-checkbox="Камень" class="checkbox">
                                            <span class="checkbox-text">Камень</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="143" data-checkbox="Космос" class="checkbox">
                                            <span class="checkbox-text">Космос</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="151" data-checkbox="Кит" class="checkbox">
                                            <span class="checkbox-text">Кит</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="178" data-checkbox="Культурный код" class="checkbox">
                                            <span class="checkbox-text">Культурный код</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">Л</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="48" data-checkbox="Лев" class="checkbox">
                                            <span class="checkbox-text">Лев</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="50" data-checkbox="Леопард" class="checkbox">
                                            <span class="checkbox-text">Леопард</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="56" data-checkbox="Люблю" class="checkbox">
                                            <span class="checkbox-text">Люблю</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="75" data-checkbox="Лилии" class="checkbox">
                                            <span class="checkbox-text">Лилии</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="77" data-checkbox="Лотос" class="checkbox">
                                            <span class="checkbox-text">Лотос</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="80" data-checkbox="Лаванда" class="checkbox">
                                            <span class="checkbox-text">Лаванда</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="83" data-checkbox="Лимон" class="checkbox">
                                            <span class="checkbox-text">Лимон</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="91" data-checkbox="Листья" class="checkbox">
                                            <span class="checkbox-text">Листья</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="97" data-checkbox="Лес" class="checkbox">
                                            <span class="checkbox-text">Лес</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="104" data-checkbox="Лондон" class="checkbox">
                                            <span class="checkbox-text">Лондон</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="127" data-checkbox="Латте" class="checkbox">
                                            <span class="checkbox-text">Латте</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="140" data-checkbox="Луна" class="checkbox">
                                            <span class="checkbox-text">Луна</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="173" data-checkbox="Лиса" class="checkbox">
                                            <span class="checkbox-text">Лиса</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">М</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="35" data-checkbox="Маме" class="checkbox">
                                            <span class="checkbox-text">Маме</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="49" data-checkbox="Мужу" class="checkbox">
                                            <span class="checkbox-text">Мужу</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="79" data-checkbox="Магнолия" class="checkbox">
                                            <span class="checkbox-text">Магнолия</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="96" data-checkbox="Море" class="checkbox">
                                            <span class="checkbox-text">Море</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="103" data-checkbox="Мандала" class="checkbox">
                                            <span class="checkbox-text">Мандала</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="122" data-checkbox="Мрамор " class="checkbox">
                                            <span class="checkbox-text">Мрамор </span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="124" data-checkbox="Мороженое" class="checkbox">
                                            <span class="checkbox-text">Мороженое</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="125" data-checkbox="Металл" class="checkbox">
                                            <span class="checkbox-text">Металл</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="128" data-checkbox="Машины" class="checkbox">
                                            <span class="checkbox-text">Машины</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="129" data-checkbox="Мокко" class="checkbox">
                                            <span class="checkbox-text">Мокко</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="132" data-checkbox="Меню" class="checkbox">
                                            <span class="checkbox-text">Меню</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="152" data-checkbox="Маяк" class="checkbox">
                                            <span class="checkbox-text">Маяк</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="161" data-checkbox="Мотиватор" class="checkbox">
                                            <span class="checkbox-text">Мотиватор</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="165" data-checkbox="Музыка" class="checkbox">
                                            <span class="checkbox-text">Музыка</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="168" data-checkbox="Мотоцикл" class="checkbox">
                                            <span class="checkbox-text">Мотоцикл</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">Н</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="23" data-checkbox="Новый год" class="checkbox">
                                            <span class="checkbox-text">Новый год</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="106" data-checkbox="Нью-Йорк" class="checkbox">
                                            <span class="checkbox-text">Нью-Йорк</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">О</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="65" data-checkbox="Одуванчики" class="checkbox">
                                            <span class="checkbox-text">Одуванчики</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="76" data-checkbox="Орхидеи" class="checkbox">
                                            <span class="checkbox-text">Орхидеи</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="88" data-checkbox="Овощи" class="checkbox">
                                            <span class="checkbox-text">Овощи</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="101" data-checkbox="Остров" class="checkbox">
                                            <span class="checkbox-text">Остров</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="108" data-checkbox="Окно" class="checkbox">
                                            <span class="checkbox-text">Окно</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">П</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="39" data-checkbox="Подарок" class="checkbox">
                                            <span class="checkbox-text">Подарок</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="42" data-checkbox="Птицы" class="checkbox">
                                            <span class="checkbox-text">Птицы</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="27" data-checkbox="Пасха" class="checkbox">
                                            <span class="checkbox-text">Пасха</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="34" data-checkbox="Папе" class="checkbox">
                                            <span class="checkbox-text">Папе</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="47" data-checkbox="Перья" class="checkbox">
                                            <span class="checkbox-text">Перья</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="54" data-checkbox="Подруге и другу" class="checkbox">
                                            <span class="checkbox-text">Подруге и другу</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="59" data-checkbox="Паук" class="checkbox">
                                            <span class="checkbox-text">Паук</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="63" data-checkbox="Профессия" class="checkbox">
                                            <span class="checkbox-text">Профессия</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="70" data-checkbox="Пионы" class="checkbox">
                                            <span class="checkbox-text">Пионы</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="87" data-checkbox="Папоротник" class="checkbox">
                                            <span class="checkbox-text">Папоротник</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="94" data-checkbox="Природа" class="checkbox">
                                            <span class="checkbox-text">Природа</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="98" data-checkbox="Пальмы" class="checkbox">
                                            <span class="checkbox-text">Пальмы</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="100" data-checkbox="Пляж" class="checkbox">
                                            <span class="checkbox-text">Пляж</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="102" data-checkbox="Париж" class="checkbox">
                                            <span class="checkbox-text">Париж</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="112" data-checkbox="Приколы" class="checkbox">
                                            <span class="checkbox-text">Приколы</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="117" data-checkbox="Пейзаж" class="checkbox">
                                            <span class="checkbox-text">Пейзаж</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="118" data-checkbox="Портрет" class="checkbox">
                                            <span class="checkbox-text">Портрет</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="130" data-checkbox="Поезд" class="checkbox">
                                            <span class="checkbox-text">Поезд</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="137" data-checkbox="Пончики" class="checkbox">
                                            <span class="checkbox-text">Пончики</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="138" data-checkbox="Планеты" class="checkbox">
                                            <span class="checkbox-text">Планеты</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="157" data-checkbox="Подсолнухи" class="checkbox">
                                            <span class="checkbox-text">Подсолнухи</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="158" data-checkbox="Правила" class="checkbox">
                                            <span class="checkbox-text">Правила</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="174" data-checkbox="Панда" class="checkbox">
                                            <span class="checkbox-text">Панда</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">Р</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="51" data-checkbox="Рыбы" class="checkbox">
                                            <span class="checkbox-text">Рыбы</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="67" data-checkbox="Ромашки" class="checkbox">
                                            <span class="checkbox-text">Ромашки</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="69" data-checkbox="Розы" class="checkbox">
                                            <span class="checkbox-text">Розы</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="89" data-checkbox="Растения" class="checkbox">
                                            <span class="checkbox-text">Растения</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="154" data-checkbox="Ретро" class="checkbox">
                                            <span class="checkbox-text">Ретро</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">С</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="46" data-checkbox="Свекрови" class="checkbox">
                                            <span class="checkbox-text">Свекрови</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="43" data-checkbox="Сестре и брату" class="checkbox">
                                            <span class="checkbox-text">Сестре и брату</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="45" data-checkbox="Собака" class="checkbox">
                                            <span class="checkbox-text">Собака</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="71" data-checkbox="Сакура" class="checkbox">
                                            <span class="checkbox-text">Сакура</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="114" data-checkbox="С надписью" class="checkbox">
                                            <span class="checkbox-text">С надписью</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="141" data-checkbox="Солнце" class="checkbox">
                                            <span class="checkbox-text">Солнце</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="160" data-checkbox="Спорт" class="checkbox">
                                            <span class="checkbox-text">Спорт</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="164" data-checkbox="Специи" class="checkbox">
                                            <span class="checkbox-text">Специи</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="166" data-checkbox="Самолет" class="checkbox">
                                            <span class="checkbox-text">Самолет</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">Т</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="52" data-checkbox="Тёще" class="checkbox">
                                            <span class="checkbox-text">Тёще</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="53" data-checkbox="Тигр" class="checkbox">
                                            <span class="checkbox-text">Тигр</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="73" data-checkbox="Тюльпаны" class="checkbox">
                                            <span class="checkbox-text">Тюльпаны</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="90" data-checkbox="Тыква" class="checkbox">
                                            <span class="checkbox-text">Тыква</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="115" data-checkbox="Тадж-Махал" class="checkbox">
                                            <span class="checkbox-text">Тадж-Махал</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">У</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="68" data-checkbox="Учителю и воспитателю " class="checkbox">
                                            <span class="checkbox-text">Учителю и воспитателю </span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="113" data-checkbox="Улица" class="checkbox">
                                            <span class="checkbox-text">Улица</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">Ф</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="57" data-checkbox="Фламинго" class="checkbox">
                                            <span class="checkbox-text">Фламинго</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="72" data-checkbox="Фрукты" class="checkbox">
                                            <span class="checkbox-text">Фрукты</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="111" data-checkbox="Фреска" class="checkbox">
                                            <span class="checkbox-text">Фреска</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">Х</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="66" data-checkbox="Хобби" class="checkbox">
                                            <span class="checkbox-text">Хобби</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">Ц</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="62" data-checkbox="Цифры" class="checkbox">
                                            <span class="checkbox-text">Цифры</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="64" data-checkbox="Цветы и растения" class="checkbox">
                                            <span class="checkbox-text">Цветы и растения</span>
                                        </label>
                                    </div><div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="162" data-checkbox="Цитаты" class="checkbox">
                                            <span class="checkbox-text">Цитаты</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">Ч</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="134" data-checkbox="Чай" class="checkbox">
                                            <span class="checkbox-text">Чай</span>
                                        </label>
                                    </div>                                    
                                </div><div class="columns-list__item">
                                    <div class="columns-list__letter">Я</div>
                                   <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" name="tag_ids[]" value="74" data-checkbox="Ягоды" class="checkbox">
                                            <span class="checkbox-text">Ягоды</span>
                                        </label>
                                    </div>                                    
                                </div></div>
                        </div>
                        <div class="modal-footer center">
                            <button type="button" class="btn" data-checkbox-btn>Выбрать</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--Цвета-->
        <div data-qf-item="4" class="timeline-pane container-small v_hidden">
            <input type="hidden" name="colors">
            <h3 class="md-visible">Цвета</h3>

            <div class="blockquote">
                Выберите цвета: минимум один, максимум три.
            </div>

            <div class="btn-group" data-checkbox-results>
                <button type="button" data-micromodal-trigger="modal-color" class="btn btn--line btn--small">
                    Выбрать
                </button>


                <template data-checkbox-tpl>
                    <button type="button" data-checkbox-value="$id" class="btn btn--line btn--small btn--tag">
                        $name
                    </button>
                </template>
            </div>

            <div id="modal-color" aria-hidden="true" class="modal">
                <div data-micromodal-close class="modal-overlay">
                    <div class="modal-main">
                        <div class="modal-close" data-micromodal-close></div>
                        <div class="modal-content scrollbar">
                                                                                    <div class="columns-list">
                                                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="1" class="checkbox" name="colors[]" data-checkbox="бежевый">
                                        <span class="checkbox-text">бежевый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="2" class="checkbox" name="colors[]" data-checkbox="белый">
                                        <span class="checkbox-text">белый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="3" class="checkbox" name="colors[]" data-checkbox="бирюзовый">
                                        <span class="checkbox-text">бирюзовый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="4" class="checkbox" name="colors[]" data-checkbox="бордовый">
                                        <span class="checkbox-text">бордовый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="5" class="checkbox" name="colors[]" data-checkbox="голубой">
                                        <span class="checkbox-text">голубой</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="6" class="checkbox" name="colors[]" data-checkbox="горчичный">
                                        <span class="checkbox-text">горчичный</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="7" class="checkbox" name="colors[]" data-checkbox="желтый">
                                        <span class="checkbox-text">желтый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="8" class="checkbox" name="colors[]" data-checkbox="зеленый">
                                        <span class="checkbox-text">зеленый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="9" class="checkbox" name="colors[]" data-checkbox="коралловый">
                                        <span class="checkbox-text">коралловый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="10" class="checkbox" name="colors[]" data-checkbox="коричневый">
                                        <span class="checkbox-text">коричневый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="11" class="checkbox" name="colors[]" data-checkbox="красный">
                                        <span class="checkbox-text">красный</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="12" class="checkbox" name="colors[]" data-checkbox="кремовый">
                                        <span class="checkbox-text">кремовый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="13" class="checkbox" name="colors[]" data-checkbox="лазурный">
                                        <span class="checkbox-text">лазурный</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="14" class="checkbox" name="colors[]" data-checkbox="лиловый">
                                        <span class="checkbox-text">лиловый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="15" class="checkbox" name="colors[]" data-checkbox="малиновый">
                                        <span class="checkbox-text">малиновый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="16" class="checkbox" name="colors[]" data-checkbox="оливковый">
                                        <span class="checkbox-text">оливковый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="17" class="checkbox" name="colors[]" data-checkbox="оранжевый">
                                        <span class="checkbox-text">оранжевый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="18" class="checkbox" name="colors[]" data-checkbox="перламутровый">
                                        <span class="checkbox-text">перламутровый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="19" class="checkbox" name="colors[]" data-checkbox="розовый">
                                        <span class="checkbox-text">розовый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="20" class="checkbox" name="colors[]" data-checkbox="салатовый">
                                        <span class="checkbox-text">салатовый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="21" class="checkbox" name="colors[]" data-checkbox="светло-бежевый">
                                        <span class="checkbox-text">светло-бежевый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="22" class="checkbox" name="colors[]" data-checkbox="светло-желтый">
                                        <span class="checkbox-text">светло-желтый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="23" class="checkbox" name="colors[]" data-checkbox="светло-зеленый">
                                        <span class="checkbox-text">светло-зеленый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="24" class="checkbox" name="colors[]" data-checkbox="светло-коричневый">
                                        <span class="checkbox-text">светло-коричневый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="25" class="checkbox" name="colors[]" data-checkbox="светло-розовый">
                                        <span class="checkbox-text">светло-розовый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="26" class="checkbox" name="colors[]" data-checkbox="светло-серый">
                                        <span class="checkbox-text">светло-серый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="27" class="checkbox" name="colors[]" data-checkbox="светло-синий">
                                        <span class="checkbox-text">светло-синий</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="28" class="checkbox" name="colors[]" data-checkbox="серый">
                                        <span class="checkbox-text">серый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="29" class="checkbox" name="colors[]" data-checkbox="синий">
                                        <span class="checkbox-text">синий</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="30" class="checkbox" name="colors[]" data-checkbox="сиреневый">
                                        <span class="checkbox-text">сиреневый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="31" class="checkbox" name="colors[]" data-checkbox="слоновая кость">
                                        <span class="checkbox-text">слоновая кость</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="32" class="checkbox" name="colors[]" data-checkbox="темно-бежевый">
                                        <span class="checkbox-text">темно-бежевый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="33" class="checkbox" name="colors[]" data-checkbox="темно-бордовый">
                                        <span class="checkbox-text">темно-бордовый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="34" class="checkbox" name="colors[]" data-checkbox="темно-зеленый">
                                        <span class="checkbox-text">темно-зеленый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="35" class="checkbox" name="colors[]" data-checkbox="темно-коричневый">
                                        <span class="checkbox-text">темно-коричневый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="36" class="checkbox" name="colors[]" data-checkbox="темно-розовый">
                                        <span class="checkbox-text">темно-розовый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="37" class="checkbox" name="colors[]" data-checkbox="темно-серый">
                                        <span class="checkbox-text">темно-серый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="38" class="checkbox" name="colors[]" data-checkbox="темно-синий">
                                        <span class="checkbox-text">темно-синий</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="39" class="checkbox" name="colors[]" data-checkbox="фиолетовый">
                                        <span class="checkbox-text">фиолетовый</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="40" class="checkbox" name="colors[]" data-checkbox="фуксия">
                                        <span class="checkbox-text">фуксия</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="41" class="checkbox" name="colors[]" data-checkbox="хаки">
                                        <span class="checkbox-text">хаки</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="42" class="checkbox" name="colors[]" data-checkbox="черный">
                                        <span class="checkbox-text">черный</span>
                                    </label>
                                </div>
                                                                <div class="columns-list__name">
                                    <label class="checkbox-label">
                                        <input type="checkbox" value="43" class="checkbox" name="colors[]" data-checkbox="шоколадный">
                                        <span class="checkbox-text">шоколадный</span>
                                    </label>
                                </div>
                                                            </div>
                                                    </div>
                        <div class="modal-footer center">
                            <button type="button" class="btn" data-checkbox-btn>Выбрать</button>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!--Комментарий-->
        <div data-qf-item="5" class="timeline-pane container-small v_hidden">

            <h3 class="md-visible">Комментарий</h3>

            <div class="blockquote">
                Введите комментарий. Это поле не обязательное для заполнения
            </div>

            <textarea class="input textarea" name="introtext" placeholder="Информация для модератора"></textarea>

        </div>

        <div data-qf-finish class="v_hidden"><p>
                Тут надо написать что-то для дизайнера после загрузки дизайна.
            </p></div>

        <div class="btn-footer">
            <button data-qf-btn="prev" class="btn btn--blue" type="button">Назад</button>
            <button data-qf-btn="next" class="btn" type="button">Далее</button>
            <div data-qf-btn="reset" class="v_hidden">
                <button class="btn" type="reset">Загрузить новый</button>
            </div>
            <button data-qf-btn="send" class="btn v_hidden" type="submit">Загрузить</button>
        </div>
    </form>


</div>{set $section = '!getStaticSection'| snippet:['section_name' => 'user_faq', 'lang_key' => '']}{if $section}{set $title = $section.title}{set $target = $section.target}{set $btn_text = $section.btn_text}{set $subtitle = $section.subtitle}{set $list_faq = $section.list_faq}{set $position = $section.position}{set $contacts = $section.contacts}{/if}<div id="user_faq_17073913863516">
    {if ('user_allow_add' | placeholder) || $_modx->resource.template !== 12}
    <div class="page-layout offset-top">
        <div class="page-layout__content container-medium">

            <div class="head">
                <div class="head-title">{$title}</div>
                <div class="head-more">
                    <a href="{$target | resource: 'uri'}">{$btn_text}</a>
                </div>
            </div>

            <div class="page">{$subtitle}</div>

            <div data-tab-wrapper>{'getFAQ' | snippet: [
                        'data' => $list_faq,
'wrapTpl' => '@FILE chunks/getfaq/default/wrap.tpl',
'navItemTpl' => '@FILE chunks/getfaq/default/nav_item.tpl',
'tabTpl' => '@FILE chunks/getfaq/default/tab.tpl',
'questionTpl' => '@FILE chunks/getfaq/default/item.tpl',
]}</div>

            
        </div>

        <div class="page-layout__aside">{'pdoResources' | snippet: [
                        'parents' => '51971',
'tpl' => '@FILE chunks/pdoresources/help_aside/item.tpl',
'resources' => '51973,51974',
'includeTVs' => 'img',
'tvPrefix' => '',
'sortby' => '{ "menuindex":"ASC"}',
'extends' => 'pdoresources.help_aside',
]}</div>
    </div>
    {/if}
</div>