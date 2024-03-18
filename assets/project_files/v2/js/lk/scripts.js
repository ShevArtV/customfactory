import CustomSelect from './custom_select.js';

document.addEventListener('DOMContentLoaded', () => {

    /**
     * https://air-datepicker.com/
     */
    /*$('.js-datepicker').each(function () {
        const _this = $(this)
        const datepicker = $('[data-datepicker]', _this)
        const datepickerValue = datepicker.data('datepicker')
        const min = $('.js-datepicker-min', _this)
        const max = $('.js-datepicker-max', _this)

        new AirDatepicker('#' + datepickerValue, {
            inline: true,
            range: true,
            multipleDatesSeparator: '-',
            prevHtml: '<svg viewBox="0 0 8 14"><path d="M7 1L1 7L7 13"/></svg>',
            nextHtml: '<svg viewBox="0 0 8 14"><path d="M1 13L7 7L1 1"/></svg>',
            onSelect() {
                min.val(datepicker.val().split('-')[0])
                max.val(datepicker.val().split('-')[1])
            }
        })
    })*/

    const project = {
        customSelectConfig: {
            hideClass: 'd-none'
        },
        imaskScriptPath: 'assets/project_files/v2/js/lk/imask.js',
        datepickerJavaScriptPath: 'assets/project_files/v2/js/lk/air-datepicker.js',
        datepickerStylesPath: 'assets/project_files/v2/css/lk/air-datepicker.css',
        fancyboxJavaScriptPath: 'assets/project_files/v2/js/lk/fancybox.umd.js',
        fancyboxStylesPath: 'assets/project_files/v2/css/lk/fancybox.css',

        toggleTab(e) {
            const trigger = e.target.closest('[data-tab-target]');
            const tabId = trigger.dataset.tabTarget;
            const wrapper = trigger.closest('[data-tab-wrapper]');
            const triggers = wrapper.querySelectorAll('[data-tab-target]');
            const tabs = wrapper.querySelectorAll('[data-tab-item]');
            triggers.forEach(el => {
                el === trigger ? el.classList.add('active') : el.classList.remove('active')
            })

            tabs.forEach(el => {
                el.dataset.tabItem === tabId ? el.classList.add('active') : el.classList.remove('active')
            })
        },
        toggleFields(e) {
            const trigger = e.target.closest('[name="legal_form"]');
            const fields = document.querySelectorAll(`[data-legal-form]`);
            fields.forEach(el => {
                el.dataset.legalForm === trigger.value ? el.classList.remove('d-none') : el.classList.add('d-none');
            });
        },
        syncFields(e) {
            const trigger = e.target.closest('[data-match-donor]');
            const donorSelectors = trigger.dataset.matchDonor.split(',');
            donorSelectors.forEach(selector => {
                const donor = document.querySelector(`[name="${selector}"]`);
                const recepient = document.querySelector(`[name="${donor.dataset.matchRecepient}"]`);
                recepient.value = trigger.checked ? donor.value : '';
            });
        },
        enableSizes() {
            const triggers = document.querySelectorAll('[data-size-target]');
            triggers.forEach(el => {
                document.querySelector(`${el.dataset.sizeTarget}`).disabled = !(el.checked);
            })
        },
        setCompleteOnChange() {
            const item = document.querySelector('[data-qf-item]:not(.v_hidden)');
            item && project.setComplete(item);
        },
        setComplete(item) {
            const itemId = item.dataset.qfItem;
            const step = document.querySelector(`[data-qf-step="${itemId}"]`);
            let checked = false;
            switch (itemId) {
                case '1':
                    checked = item.querySelector('[name="parent"]:checked');
                    break;
                case '2':
                    checked = Boolean(item.querySelector('[name="filelist"]').value);
                    break;
                case '3':
                    checked = Boolean(item.querySelector('[name="tags"]').value);
                    break;
                case '4':
                    checked = Boolean(item.querySelector('[name="colors"]').value);
                    break;
                case '5':
                    checked = Boolean(item.querySelector('[name="introtext"]').value);
                    break;
            }
            step.classList[checked ? 'add' : 'remove']('complete');
        },
        showSelectedCheckbox(target) {
            const root = document.querySelector(`[data-qf-item="${target.dataset.checkboxBtn}"]`);
            const modal = target.closest('.modal');
            const selectedCheckbox = modal.querySelectorAll('[data-checkbox]:checked');
            const results = root.querySelector('[data-checkbox-results]');
            const preview = root.querySelectorAll('[data-checkbox-value]');
            const tpl = root.querySelector('[data-checkbox-tpl]');
            preview && preview.forEach(item => item.remove());
            if (selectedCheckbox.length) {
                selectedCheckbox.forEach(item => {
                    const clone = tpl.cloneNode(true);
                    results.innerHTML += clone.innerHTML.replaceAll('$id', item.value).replaceAll('$name', item.dataset.checkbox);
                })
                document.querySelector(`[data-qf-step="${root.dataset.qfItem}"]`).classList.add('complete');
            } else {
                document.querySelector(`[data-qf-step="${root.dataset.qfItem}"]`).classList.remove('complete');
            }

            project.modalClose(modal);
        },
        removeSelectedCheckbox(e) {
            const root = e.target.closest('[data-qf-item]');
            const target = e.target.closest('[data-checkbox-value]');
            const selectedCheckbox = root.querySelector(`input[value="${target.dataset.checkboxValue}"]`);
            target && target.remove();
            selectedCheckbox && (selectedCheckbox.checked = false);
            const previews = root.querySelectorAll('[data-checkbox-value]');
            !previews.length && document.querySelector(`[data-qf-step="${root.dataset.qfItem}"]`).classList.remove('complete');
            if (selectedCheckbox.name === 'data[color][]') {
                project.checkMaxColors(selectedCheckbox.closest('form'), selectedCheckbox);
            }
        },
        modalShow(target) {
            if (typeof Fancybox !== 'undefined') {
                Fancybox.show([{src: target.dataset.modalShow, type: "inline"}]);
            }
        },
        modalClose() {
            if (typeof Fancybox !== 'undefined') {
                Fancybox.close();
            }
        },
        checkMaxColors(form, target) {
            const leftTextBlock = document.querySelector('[data-js-left]');
            const colors = document.querySelectorAll('[name="data[color][]"]:checked');
            if (colors.length > 3) {
                target.checked = false;
                SendIt.Notify.error('Выбрано максимальное количество цветов.');
            } else if (colors.length === 3) {
                leftTextBlock && (leftTextBlock.textContent = 'Выбраны все цвета')
            } else if (colors.length === 2) {
                leftTextBlock && (leftTextBlock.textContent = 'Можете выбрать ещё 1 цвет')
            } else if (colors.length === 1) {
                leftTextBlock && (leftTextBlock.textContent = 'Можете выбрать ещё 2 цвета')
            } else {
                leftTextBlock && (leftTextBlock.textContent = 'Можете выбрать 3 цвета')
            }
        },
        setTags() {
            const tag = document.querySelector('[name="data[tag_label]"]:checked');
            const target = document.querySelector('[name="data[tags][]"]');
            target.value = tag.dataset.checkbox;
        },
        clearFileList(e) {
            const fileWrap = document.querySelector('[data-fu-wrap]');
            if (SendIt?.FileUploaderFactory?.instances.has(fileWrap)) {
                SendIt?.FileUploaderFactory?.instances.get(fileWrap).clearFields();
            }
        },
        copyText(e) {
            var text = e.target.closest('[data-copy]').innerText;
            navigator.clipboard.writeText(text);
            SendIt?.Notify?.success('Текст скопирован.');
        },
        loadScript(path, callback, cssPath) {
            if (document.querySelector('script[src="' + path + '"]')) {
                callback(path, "ok");
                return;
            }
            let done = false,
                scr = document.createElement('script');

            scr.onload = handleLoad;
            scr.onreadystatechange = handleReadyStateChange;
            scr.onerror = handleError;
            scr.src = path;
            document.body.appendChild(scr);

            function handleLoad() {
                if (!done) {
                    if (cssPath) {
                        let css = document.createElement('link');
                        css.rel = 'stylesheet';
                        css.href = cssPath;
                        document.head.prepend(css);
                    }
                    done = true;
                    callback(path, "ok");
                }
            }

            function handleReadyStateChange() {
                let state;

                if (!done) {
                    state = scr.readyState;
                    if (state === "complete") {
                        handleLoad();
                    }
                }
            }

            function handleError() {
                if (!done) {
                    done = true;
                    callback(path, "error");
                }
            }
        },
        toggleStep(step) {
            const root = step.closest('[data-si-form]');
            root && SendIt?.QuizForm?.change(root, step.dataset.qfStep, true);
        },
        selectAll() {
            const selectedIds = document.querySelectorAll('[name="selected_id[]"]');
            selectedIds && selectedIds.forEach(el => el.checked = true)
        },
        unSelectAll() {
            const selectedIds = document.querySelectorAll('[name="selected_id[]"]');
            const selectedToggler = document.querySelector('[data-select-all]');
            selectedIds && selectedIds.forEach(el => el.checked = false)
            selectedToggler && (selectedToggler.checked = false)
        },
        changeUserProfileView(target) {
            const fields = target.querySelectorAll('input, select, textarea, button[type="submit"]');
            const blockquotes = target.querySelectorAll('.blockquote');
            fields && fields.forEach(field => field.disabled = true)
            blockquotes && blockquotes.forEach(el => el.classList.add('d-none'));
            target.querySelector('.blockquote_warning').classList.remove('d-none');
        },
        async updateFiltersView() {
            const selectAll = document.querySelector('[data-select-all]');
            selectAll && (selectAll.checked = false);
            await FlatFilters.MainHandler.update();
        },
        enterComment(target) {
            if ([3, 5].includes(Number(target.value))) {
                Fancybox.show([{src: '#modal-comment', type: "inline"}]);
            }
        },
        selectCaption(target) {
            const form = target.closest('form');
            const caption = form.querySelector(`[data-caption="${target.dataset.key}"]`);
            caption && (caption.checked = target.checked);
        },
        startDownload(path, filename) {
            fetch(path)
                .then(response => response.blob())
                .then(blob => {
                    const url = window.URL.createObjectURL(blob);
                    const a = document.createElement('a');
                    a.href = url;
                    a.download = filename;
                    a.click();
                    window.URL.revokeObjectURL(url);
                })
                .catch(error => {
                    SendIt?.Notify?.error('Не удалось скачать файл.');
                    console.error('Ошибка загрузки файла:', error);
                });
        },
        popupShow(target) {
            project.popupClose()
            const popup = document.querySelector(`[data-popup="${target.dataset.popupLink}"]`);
            popup && popup.classList.add('show-popup');
        },
        popupClose() {
            const popups = document.querySelectorAll('.show-popup');
            popups.length && popups.forEach(el => el.classList.remove('show-popup'))
        },
        getDatepickerElements() {
            return {
                datePickerField: document.querySelector('[data-datepicker]'),
                datePickerFieldMin: document.querySelector('.js-datepicker-min'),
                datePickerFieldMax: document.querySelector('.js-datepicker-max'),
                selectDateText: document.querySelector('[data-popup-link="datepicker"]')
            }
        },
        selectPeriod(target) {
            if (typeof dp !== 'undefined') {
                const {selectDateText} = project.getDatepickerElements();
                const dates = target.dataset.periodValue.split(',');
                const start = dates[0].split('.').reverse().join('-');
                const end = dates[1].split('.').reverse().join('-');
                dp.selectDate([new Date(start), new Date(end)]);
                setTimeout(() => {
                    selectDateText && (selectDateText.textContent = target.textContent)
                }, 10)
            }
        },
        triggerChangePeriod() {
            const datePickerField = document.querySelector('[data-datepicker]');
            datePickerField && datePickerField.dispatchEvent(new Event('change', {bubbles: true}));
            project.popupClose();
        }
    }

    // кастомный селект
    CustomSelect.create(project.customSelectConfig);

    // маски ввода
    project.loadScript(project.imaskScriptPath, () => {
        const phoneInputs = document.querySelectorAll('[name="phone"]');
        if (phoneInputs) {
            phoneInputs.forEach(el => {
                IMask(el, {mask: '+{7}(000)000-00-00'})
            })
        }
        const zipInputs = document.querySelectorAll('[name="zip_fact"], [name="zip"]');
        if (zipInputs) {
            zipInputs.forEach(el => {
                IMask(el, {mask: /^[1-6]\d{0,5}$/})
            })
        }
        const dateInputs = document.querySelectorAll('[name="extended[pass_date]"], [name="dob"]');
        if (dateInputs) {
            dateInputs.forEach(el => {
                IMask(el, {mask: Date, pattern: 'd{.}`m{.}`Y'})
            })
        }
        document.querySelector('[name="pass_series"]') && IMask(document.querySelector('[name="pass_series"]'), {mask: '0000'})
        document.querySelector('[name="pass_num"]') && IMask(document.querySelector('[name="pass_num"]'), {mask: '000 000'})
        document.querySelector('[name="extended[pass_code]"]') && IMask(document.querySelector('[name="extended[pass_code]"]'), {mask: '000-000'})
        document.querySelector('[name="inn"]') && IMask(document.querySelector('[name="inn"]'), {mask: '000 000 000 000'})
        document.querySelector('[name="extended[ogrnip]"]') && IMask(document.querySelector('[name="extended[ogrnip]"]'), {mask: '000 000 000 000 000'})
        document.querySelector('[name="extended[bik]"]') && IMask(document.querySelector('[name="extended[bik]"]'), {mask: '000 000 000'})
        document.querySelector('[name="extended[rs]"]') && IMask(document.querySelector('[name="extended[rs]"]'), {mask: '000 000 000 000 000 000 00'})
    });

    // datepicker
    project.loadScript(project.datepickerJavaScriptPath, () => {
        const {datePickerField, datePickerFieldMin, datePickerFieldMax, selectDateText} = project.getDatepickerElements();

        if (datePickerField) {
            window.dp = new AirDatepicker(datePickerField, {
                dateFormat: 'dd.MM.yyyy',
                maxDate: new Date(),
                range: true,
                inline: true,
                multipleDatesSeparator: ',',
                prevHtml: '<svg viewBox="0 0 8 14"><path d="M7 1L1 7L7 13"/></svg>',
                nextHtml: '<svg viewBox="0 0 8 14"><path d="M1 13L7 7L1 1"/></svg>',
                onSelect({date, formattedDate, datepicker}) {
                    if (formattedDate.length === 2) {
                        datePickerField.value = formattedDate[0] + ',' + formattedDate[1];
                        datePickerFieldMin.value = formattedDate[0];
                        datePickerFieldMax.value = formattedDate[1];
                        selectDateText.textContent = formattedDate[0] + '-' + formattedDate[1]
                    }
                }
            })
        }
    }, project.datepickerStylesPath)

    // fancybox
    project.loadScript(project.fancyboxJavaScriptPath, () => {
    }, project.fancyboxStylesPath)


    document.addEventListener('click', async (e) => {
        e.target.closest('[data-tab-target]') && project.toggleTab(e)
        e.target.closest('[data-checkbox-btn]') && project.showSelectedCheckbox(e.target.closest('[data-checkbox-btn]'))
        e.target.closest('[data-micromodal-trigger]') && project.modalShow(e)
        e.target.closest('[data-checkbox-value]') && project.removeSelectedCheckbox(e)
        e.target.closest('[data-copy]') && project.copyText(e)
        e.target.closest('[data-qf-step]') && project.toggleStep(e.target.closest('[data-qf-step]'))
        e.target.closest('[data-unselect-all]') && project.unSelectAll()
        e.target.closest('[data-modal-close]') && project.modalClose()
        e.target.closest('[data-modal-show]') && project.modalShow(e.target.closest('[data-modal-show]'))
        e.target.closest('[data-popup-link]') && project.popupShow(e.target.closest('[data-popup-link]'))
        !e.target.closest('[data-popup]') && !e.target.closest('[data-popup-link]') && project.popupClose()
        e.target.closest('[data-period-value]') && project.selectPeriod(e.target.closest('[data-period-value]'))
        e.target.closest('[data-apply-period]') && project.triggerChangePeriod();
    })

    document.addEventListener('change', (e) => {
        e.target.closest('[name="legal_form"]') && project.toggleFields(e)
        e.target.closest('[data-match-donor]') && project.syncFields(e)
        e.target.closest('[data-size-target]') && project.enableSizes(e)
        e.target.closest('[data-qf-item]') && project.setCompleteOnChange(e)
        e.target.closest('[name="data[color][]"]') && project.checkMaxColors(e.target.form, e.target.closest('[name="data[color][]"]'))
        e.target.closest('[name="data[tag_label]"]') && project.setTags()
        e.target.closest('[name="data[root_id]"]') && project.clearFileList(e)
        e.target.closest('[data-select-all]') && project.selectAll(e.target.closest('[data-select-all]'))
        e.target.closest('[data-listuser-status]') && project.enterComment(e.target.closest('[data-listuser-status]'));
        e.target.closest('[data-key]') && project.selectCaption(e.target.closest('[data-key]'));
    })

    document.addEventListener('ff:values:disabled', (e) => {
        const customSelectEl = e.detail.element.closest('.js-custom-select');
        if (CustomSelect.instances.has(customSelectEl)) {
            CustomSelect.instances.get(customSelectEl).update(false);
        }
    })

    document.addEventListener('ff:before:render', (e) => {
        if (e.detail.eventOptions.key === 'createdon') {
            e.preventDefault();
        }
    })

    document.addEventListener('ff:after:reset', (e) => {
        if (typeof dp !== 'undefined') {
            const {datePickerField, datePickerFieldMin, datePickerFieldMax, selectDateText} = project.getDatepickerElements();
            dp.clear();
            datePickerFieldMin && (datePickerFieldMin.value = '');
            datePickerFieldMax && (datePickerFieldMax.value = '');
            selectDateText && (selectDateText.textContent = 'Не задано');
        }
    })

    document.addEventListener('ff:results:loaded', (e) => {
        CustomSelect.create(project.customSelectConfig);
        const updField = document.querySelector('[name="upd"]');
        updField && (updField.value = '');
    })

    document.addEventListener('si:send:after', (e) => {
        const {result, target, headers, Sending} = e.detail;

        switch (headers['X-SIPRESET']) {
            case 'search_tag':
                const tagsModal = target.closest('.modal');
                tagsModal && tagsModal.querySelector('[data-checkbox-wrap]') && (tagsModal.querySelector('[data-checkbox-wrap]').innerHTML = result.result)
                break;
        }
    })

    document.addEventListener('si:send:success', async (e) => {
        const {result, target, headers, Sending} = e.detail;

        switch (headers['X-SIPRESET']) {
            case 'removeFile':
                const item = target.closest('[data-qf-item]');
                item && project.setComplete(item);
                break;

            case 'add_avatar':
                await SendIt.Sending.prepareSendParams(document, 'get_avatar', 'change');
                break;

            case 'get_avatar':
                const avatar = document.querySelector('.user-avatar');
                //const modal = document.querySelector('#modal-load-avatar');
                avatar && result.data.photo && (avatar.src = result.data.photo);
                project.modalClose();
                break;

            case 'updateUser':
            case 'setStatusUsers':
            case 'removeUsers':
                project.updateFiltersView();
                break;

            case 'dataedit':
                project.changeUserProfileView(target);
                break;

            case 'quiz':
                document.querySelector('[data-qf-step="5"]').classList.add('complete');
                break;

            case 'generate_report':
                project.startDownload(result.data.path, result.data.filename);
                //const generateModal = target.closest('.modal');
                project.modalClose();
                break;
        }

        if (target === document) return false;

        if (result.data.allowFiles) {
            const errorBlock = document.querySelector(Sending.config.errorBlockSelector.replace('${fieldName}', result.data.allowFiles));
            errorBlock && (errorBlock.textContent = '')
        }
    })

    document.addEventListener('fu:uploading:start', (e) => {
        const btnPrev = document.querySelector('[data-qf-btn="prev"]');
        btnPrev && (btnPrev.disabled = true)
    })

    document.addEventListener('fu:uploading:end', (e) => {
        const btnPrev = document.querySelector('[data-qf-btn="prev"]');
        btnPrev && (btnPrev.disabled = false)
        project.setCompleteOnChange(e);
    })

    document.addEventListener('si:send:error', (e) => {
        const {result, headers, Sending} = e.detail;
        if (result.data && result.data.errors) {
            for (let k in result.data.errors) {
                k = k.replace(/extended\[|\]/g, '');
                const fields = document.querySelectorAll(`[name="${k}"]`);
                if (fields.length) {
                    fields.forEach(field => field.closest('.file')?.classList.add(Sending.config.errorClass))
                }
            }
        }

        switch (headers['X-SIPRESET']) {
            case 'setStatusUsers':
                if (result.data.errors.comment) {
                    MicroModal.show('modal-comment');
                }
                break;
        }
    })

    document.addEventListener('si:send:before', (e) => {
        const {fetchOptions, headers} = e.detail;
        if (typeof fetchOptions.body.get === 'function') {

            switch (headers['X-SIPRESET']) {
                case 'flatfilters':
                    const queryField = document.querySelector('[name="query"]');
                    queryField && FlatFilters.MainHandler.setSearchParams('text', 'query', queryField.value);
                    break;
                case 'dataedit':
                    fetchOptions.body.set('fullname', `${fetchOptions.body.get('extended[surname]')} ${fetchOptions.body.get('extended[name]')} ${fetchOptions.body.get('extended[fathername]')}`);
                    const numbers = [
                        'zip_fact',
                        'pass_num',
                        'extended[certificate_num]',
                        'extended[certificate_date]',
                        'extended[insurance]',
                        'extended[rs]',
                        'extended[bik]',
                        'extended[ogrnip]',
                        'inn',
                    ];
                    const removed = [
                        'certificate_img',
                        'inn_img',
                        'selfemployed_img',
                        'pass_one_img',
                        'pass_two_img',
                        'insurance_img',
                    ];
                    for (let pair of fetchOptions.body.entries()) {
                        if (numbers.includes(pair[0])) {
                            fetchOptions.body.set(pair[0], pair[1].replace(/\s/g, ''));
                        }
                        if (removed.includes(pair[0])) {
                            fetchOptions.body.delete(pair[0]);
                        }
                    }
                    break;
                case 'upload_design':
                    const parent = document.querySelector('[name="parent"]:checked');
                    let count = 0;
                    if (parent) {
                        const sizeSelect = document.querySelector(parent.dataset.sizeTarget);
                        const countField = document.querySelector('[name="data[count_files]"]');
                        count = sizeSelect.options[sizeSelect.selectedIndex].dataset.count;
                        countField && (countField.value = count);
                    }
                    fetchOptions.body.set('params', JSON.stringify({maxCount: count}));
                    break;
            }
        }
    })

    document.addEventListener('si:quiz:change', (e) => {
        const {current, nextItem, root, dir, isTrusted, Quiz} = e.detail;
        const step = root.querySelector(`[data-qf-step="${current.dataset[Quiz.config.itemKey]}"]`);
        const stepNext = root.querySelector(`[data-qf-step="${nextItem.dataset[Quiz.config.itemKey]}"]`);
        const stepId = current.dataset[Quiz.config.itemKey];
        if (!step.classList.contains('complete') && dir === 'next' && isTrusted) {
            let msg = '';
            switch (stepId) {
                case '1':
                    msg = 'Выберите тип и размер!'
                    break;
                case '2':
                    msg = 'Загрузите дизайн!'
                    break;
                case '3':
                    msg = 'Выберите тэги!'
                    break;
                case '4':
                    msg = 'Выберите цвета!'
                    break;
            }
            if (msg) {
                e.preventDefault();
                SendIt.Notify.error(msg);
                return;
            }
        }

        if (dir === 'next') {
            step.classList.remove("active");
            stepNext.classList.add("active");
        }
        if (dir === 'prev') {
            step.classList.remove("active");
            stepNext.classList.add("active");
        }
    })

    document.addEventListener('si:quiz:reset', (e) => {
        const {root} = e.detail;
        const parentRadio = root.querySelectorAll('[name="parent"]');
        const rootIdSelect = root.querySelectorAll('[name="data[root_id]"]');
        const checkboxValues = root.querySelectorAll('[data-checkbox-value]');
        const steps = root.querySelectorAll('[data-qf-step]');
        parentRadio.length && parentRadio.forEach(el => el.checked = false)
        rootIdSelect.length && rootIdSelect.forEach(el => el.disabled = true)
        checkboxValues.length && checkboxValues.forEach(el => el.remove())
        steps.length && steps.forEach(el => {
            el.classList.remove('complete');
            el.classList[el.dataset.qfStep !== '1' ? 'remove' : 'add']('active');
        })
    })
})