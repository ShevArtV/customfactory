export default class CustomSelect {

    static instances = new Map();
    static changeEvent = new Event('change', {bubbles: true, cancelable: true});

    static create(config = {}) {
        const defaults = {
            selector: '.js-custom-select',
            openClass: 'open',
            selectedClass: 'selected',
            disabledClass: 'disabled',
            initClass: 'initialized',
            hideClass: 'v_hidden',
            creatable: {
                listWrap: {
                    tagName: 'div',
                    className: ['select'],
                },
                scrollWrap: {
                    tagName: 'div',
                    className: ['select__wrap'],
                    parentSelector: '.select'
                },
                list: {
                    className: ['select__list'],
                    tagName: 'ul',
                    parentSelector: '.select__wrap'
                },
                listItem: {
                    className: ['select__item'],
                    tagName: 'li',
                    parentSelector: '.select__list'
                },
                selectedItem: {
                    className: ['select__item_selected'],
                    tagName: 'span',
                    parentSelector: '.select'
                }
            },
        }

        config = Object.assign(defaults, config);

        const selects = document.querySelectorAll(config.selector);
        if (!selects) {
            throw new Error(`В документе не найдено форм по селектору: ${config.selector}`);
        }

        selects.forEach(select => {
            if (!select.classList.contains(config.initClass)) {
                new this(select, config);
            }
        });

        document.body.addEventListener('click', e => {
            if (!e.target.closest(config.selector)) {
                selects.forEach(select => {
                    select.classList.remove(config.openClass);
                });
            }
        });
    }

    constructor(element, config) {
        this.element = element;
        this.config = config;

        this.initialize();

        CustomSelect.instances.set(this.element, this);
    }

    initialize() {
        this.select = this.element.querySelector(`select`);
        if (!this.select) return false;
        this.options = this.select.querySelectorAll('option');
        if (!this.options) return false;

        const selectClasses = Array.from(this.select.classList);
        const optionSelected = this.select.querySelector('option[selected]') || this.options[0];

        this.select.classList.add(this.config.hideClass);

        for (let key in this.config.creatable) {
            const tagName = this.config.creatable[key]['tagName'];
            const parentEl = (key === 'listWrap') ? this.element : this.element.querySelector(this.config.creatable[key]['parentSelector']);
            let classNames = this.config.creatable[key]['className'];
            if (key === 'listItem') {
                this.options.forEach(el => {
                    let item = this.createElement(tagName, parentEl, classNames, el.value, el.innerText, el.selected, el.disabled);
                    item.addEventListener('click', e => this.selectItem(e, this.select, this.element, true));
                });
            } else if (key === 'selectedItem') {
                this.createElement(tagName, parentEl, classNames, '', optionSelected?.innerText);
            } else if (key === 'listWrap') {
                classNames = classNames.concat(selectClasses);
                classNames = classNames.filter(el => el !== this.config.hideClass);
                this.createElement(tagName, parentEl, classNames);
            } else {
                this.createElement(tagName, parentEl, classNames);
            }
        }
        const selectedItem = this.element.querySelector('.' + this.config.creatable.selectedItem.className);
        selectedItem.addEventListener('click', e => this.element.classList.toggle(this.config.openClass));
        this.element.classList.add(this.config.initClass);
    }

    reset() {
        const item = this.element.querySelector('.' + this.config.creatable.listItem.className);
        item.dispatchEvent(new Event('click'));
    }

    update(dispatch = true) {
        const list = this.element.querySelector('.' + this.config.creatable.list.className);
        const tagName = this.config.creatable.listItem.tagName;
        const classNames = this.config.creatable.listItem.className;

        list.innerHTML = '';
        this.options.forEach(el => {
            let item = this.createElement(tagName, list, classNames, el.value, el.innerText, el.selected, el.disabled, el.style.display);
            item.addEventListener('click', e => this.selectItem(e, true));
            if (el.selected && dispatch) {
                item.dispatchEvent(new Event('click'));
            }
        });
    }

    toggleClass(e, element) {
        const opens = document.querySelectorAll('.' + this.config.openClass);
        if (opens.length) {
            opens.forEach(el => {
                if (el !== element) {
                    el.classList.remove(this.config.openClass);
                }
            });
        }
        element.classList.toggle(this.config.openClass);
    }

    selectItem(e, dispatch = true) {
        const customSelectItems = this.element.querySelectorAll('.' + this.config.creatable.listItem.className);
        const option = e.target.tagName === 'SELECT' ? this.select.options[this.select.selectedIndex] : e.target;
        const selectedItem = this.element.querySelector('.' + this.config.creatable.selectedItem.className);
        customSelectItems.forEach(elem => {
            elem.classList.remove(this.config.selectedClass);
        });

        if (selectedItem) {
            selectedItem.innerText = option.innerText;
        }
        this.select.value = e.target.dataset.value;
        option.classList.add(this.config.selectedClass);
        option.selected = 1;
        this.element.classList.remove(this.config.openClass);
        dispatch ? this.select.dispatchEvent(CustomSelect.changeEvent) : '';
    }

    createElement(tagName, parentEl, classNames, val, text, select, disabled, display) {
        const elem = document.createElement(tagName);
        classNames ? elem.classList.add(...classNames) : '';
        val ? elem.dataset.value = val : '';
        text ? elem.innerHTML = text : '';
        display ? elem.style.display = display : '';
        disabled ? elem.classList.add(this.config.disabledClass) : '';
        select ? elem.classList.add(this.config.selectedClass) : '';
        parentEl ? parentEl.appendChild(elem) : '';
        return elem;
    }
}