<div class="offset-top">
    <form method="post" enctype="multipart/form-data" data-si-form="uploadQuizForm" id="uploadQuizForm" data-si-preset="upload_quiz" data-si-nosave>
        <input type="hidden" name="data[pagetitle]" value="Дизайн ##$_modx->user.fullname} от ">
        <input type="hidden" name="data[alias]" value="design-">
        <input type="hidden" name="data[createdby]" value="{$_modx->user.id}">
        <input type="hidden" name="data[designer]" value="{$_modx->user.fullname}">
        <input type="hidden" name="data[status]" value="0">
        <input type="hidden" name="data[published]" value="0">
        <input type="hidden" name="data[count_files]" value="1">
        <input type="hidden" name="data[tags][]" value="">
        <input type="hidden" name="data[profilenum]" value="{$_modx->user.profile_num}">

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
                Выберите из списка тип товара, который хотите загрузить, и укажите размер
            </div>

            <div class="table-wrapper">
                <table class="type-table">
                    <thead>
                    <tr>
                        <th>Укажите тип товара</th>
                        <th>Укажите размер</th>
                        <!--
                        <th>Укажите крой</th>
                        <th>Укажите пол</th>
                        -->
                    </tr>
                    </thead>
                    <tbody>
                    ##set $designTemplates = $_modx->runSnippet('@FILE snippets/product/snippet.getdesigntemplates.php', ['prohibited_categories' => $_modx->user.prohibited_categories])}
                    ##if $designTemplates}
                    ##foreach $designTemplates as $title => $data}
                    <tr>
                        <td>
                            <label class="type-table__link">
                                <input type="radio" name="parent" value="##$data.parent}" ##$.get.parent==$data.parent?'checked': ''} data-size-target="#sizes-##$data.parent}">
                                <span>##$title}</span>
                            </label>
                        </td>
                        <td>
                            <select class="type-table__select" ##$.get.parent != $data.parent ?'disabled': ''} name="data[root_id]" id="sizes-##$data.parent}">
                                ##foreach $data.sizes as $size => $d}
                                <option value="##$d.root_id}" data-count="##$d.count_files}" ##$.get.type==$d.root_id?'selected': ''}>##$size}</option>
                                ##/foreach}
                            </select>
                        </td>
                        ##if $data.parent == 19}
                        <td>
                           {* <label class="checkbox-label">
                                <input type="checkbox" name="data[cut][]" value="Прямой" class="checkbox" tabindex="-1">
                                <span class="checkbox-text">Прямой</span>
                            </label>*}
                        </td>
                        <td>
                            <label class="checkbox-label">
                                <input type="checkbox" name="data[gender][]" value="Мужской" class="checkbox" tabindex="-1">
                                <span class="checkbox-text">Мужской</span>
                            </label>
                        </td>
                        ##/if}
                        ##if $data.parent == 54754}
                        <td>
                            <label class="checkbox-label">
                                <input type="checkbox" name="data[cut][]" value="Оверсайз" class="checkbox" tabindex="-1">
                                <span class="checkbox-text">Оверсайз</span>
                            </label>
                        </td>
                        <td>
                            <label class="checkbox-label">
                                <input type="checkbox" name="data[gender][]" value="Женский" class="checkbox" tabindex="-1">
                                <span class="checkbox-text">Женский</span>
                            </label>
                        </td>
                        ##/if}
                    </tr>
                    ##/foreach}
                    ##/if}
                    </tbody>
                </table>
            </div>


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
                <button type="button" data-modal-show="#modal-tag" class="btn btn--line btn--small">
                    Назначьте тэг
                </button>

                <template data-checkbox-tpl>
                    <button type="button" data-checkbox-value="$id" class="btn btn--line btn--small btn--tag">
                        $name
                    </button>
                </template>

            </div>

            <div id="modal-tag" aria-hidden="true" class="modal">
                <div class="modal-main">
                    <div class="modal-close" data-modal-close></div>
                    <div class="modal-title">Назначьте тэг для дизайна</div>
                    <div class="search">
                        <input type="text" class="input search-input" name="query" data-si-preset="search_tag" data-si-event="input" placeholder="введите тэг">
                    </div>
                    <div class="modal-content scrollbar">
                        <div class="columns-list" data-checkbox-wrap>{'getTagsByAlphabet' | snippet: [
                        'tplChar' => '@FILE chunks/gettagsbyalphabet/char.tpl',
'tplTag' => '@FILE chunks/gettagsbyalphabet/tag.tpl',
'tplEmpty' => '@FILE chunks/gettagsbyalphabet/empty.tpl',
]}</div>
                    </div>
                    <div class="modal-footer center">
                        <button type="button" class="btn" data-checkbox-btn="3">Выбрать</button>
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

            <div>
                <div class="btn-group" data-checkbox-results>
                    <button type="button" data-modal-show="#modal-color" class="btn btn--line btn--small">
                        Выбрать
                    </button>

                    <template data-checkbox-tpl>
                        <button type="button" data-checkbox-value="$id" class="btn btn--line btn--small btn--tag">
                            $name
                        </button>
                    </template>
                </div>


                <button type="button" data-modal-show="#modal-color" class="btn btn--glass btn--small" data-js-left>
                    Можете выбрать 3 цвета
                </button>
            </div>

            <div id="modal-color" aria-hidden="true" class="modal">
                <div class="modal-main">
                    <div class="modal-close" data-modal-close></div>
                    <div class="modal-content scrollbar">
                        {set $colors = $_modx->runSnippet('@FILE snippets/product/snippet.getcolors.php', [])}
                        {if $colors}
                            <div class="columns-list">
                                {set $colors = $colors | split: ','}
                                {foreach $colors as $color index=$id}
                                    <div class="columns-list__name">
                                        <label class="checkbox-label">
                                            <input type="checkbox" value="{$color | strip}" class="checkbox" name="data[color][]" data-color form="uploadQuizForm" data-checkbox="{$color | strip}">
                                            <span class="checkbox-text">{$color | strip}</span>
                                        </label>
                                    </div>
                                {/foreach}
                            </div>
                        {/if}
                    </div>
                    <div class="modal-footer center">
                        <button type="button" class="btn" data-checkbox-btn="4">Выбрать</button>
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

            <textarea class="input textarea" name="data[introtext]" placeholder="Информация для модератора"></textarea>

        </div>

        <div data-qf-finish class="v_hidden">{$content}</div>

        <div class="btn-footer">
            <button data-qf-btn="prev" class="btn btn--line" type="button">Назад</button>
            <button data-qf-btn="next" class="btn" type="button">Далее</button>
            <div data-qf-btn="reset" class="v_hidden">
                <button class="btn" type="reset">Загрузить новый</button>
            </div>
            <button data-qf-btn="send" class="btn v_hidden" type="submit">Загрузить</button>
        </div>
    </form>


</div>