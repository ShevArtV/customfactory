$(function () {

   const DOC = $(document),
      BODY = $('body')

   /**
    * Modal
    * https://micromodal.vercel.app/
    */
   MicroModal.init({
      awaitOpenAnimation: true,
      awaitCloseAnimation: true,
      disableScroll: true,
      onShow: modal => scrollbarOffsetAdd(),
      onClose: modal => scrollbarOffsetRemove(),
   });


   function scrollbarOffsetAdd() {
      const scrollbarWidth = window.innerWidth - document.documentElement.clientWidth;
      BODY.css('margin-right', scrollbarWidth + 'px');
   }

   function scrollbarOffsetRemove() {
      BODY.css('margin-right', '');
   }

   /**
    * Slider init
    * https://splidejs.com/guides/options/
    */
   function initSlider(sliderSelector, sliderOptions) {
      let option = {
         perPage: 2,
         breakpoints: {
            1023: {
               perPage: 2,
            },
            600: {
               perPage: 1,
            },
         }
      }
      let options = {...option, ...sliderOptions}
      new Splide(sliderSelector, options).mount();
   }

   var elms = document.getElementsByClassName('slider');

   for (var i = 0; i < elms.length; i++) {
      initSlider(elms[i], {
         perPage: 4,
      })
   }

   /**
    * Collapse
    */
   $('.js-collapse-title').on('click', function () {
      const _this = $(this)
      _this.toggleClass('active').next().stop().slideToggle(200);
   })

});

/**
 * LazyLoad
 */
/*let lazyLoad = function () {
   const observer = window.lozad('.lazy', {
      loaded: function (el) {
         el.classList.add('loaded');
      }
   });
   observer.observe();
};

$(lazyLoad);*/

/**
 * AppPopup
 */
$(function () {
   const POPUP_SELECTOR = $('[data-popup]'),
      POPUP_SHOW_CLASS = 'is-show';

   $('[data-popup-link]').on('click', function () {
      const select = $(this).data('popup-link'),
         el = $('[data-popup="' + select + '"]');
      if (el.is($('.' + POPUP_SHOW_CLASS))) {
         POPUP_SELECTOR.removeClass(POPUP_SHOW_CLASS);
      } else {
         POPUP_SELECTOR.removeClass(POPUP_SHOW_CLASS);
         el.addClass(POPUP_SHOW_CLASS);
      }
      return false;
   });

   $(document).on('click', function (e) {
      if ($(e.target).closest('.' + POPUP_SHOW_CLASS).length === 0) POPUP_SELECTOR.removeClass(POPUP_SHOW_CLASS);
   });
});

/**
 * Tabs
 */
$(function () {
   const TAB_ITEM_SELECTOR = '.js-tab-item';
   const TAB_PANE_SELECTOR = '.js-tab-pane';

   let Tabs = {
      init: function (selector) {
         $(selector).each(function () {
            const el = $(this),
               item = $(TAB_ITEM_SELECTOR, el);
            item.on('click', function () {
               const index = $(this).index();
               Tabs.pane(index, el);
            });
            Tabs.pane(0, el)
         })
      },
      pane: function (index, selector) {
         $(TAB_PANE_SELECTOR, selector)
            .eq(index)
            .add($(TAB_ITEM_SELECTOR, selector).eq(index))
            .addClass('is-active')
            .siblings()
            .removeClass('is-active');
      }
   }

   Tabs.init('.js-tabs');
   window.Tabs = Tabs || jQuery.Tabs;
});

/**
 * Notify
 */
$(function () {
   let notifyWrap = $('<div class="notify-wrap"></div>').appendTo($('body'));

   function notify(text, theme = 'default', time = 10000) {
      let notify_timer,
         notify = $('<div/>', {
            "class": 'notify',
         })
            .appendTo(notifyWrap)
            .fadeIn(200)
            .addClass('is-show ' + theme)
            .html(text);
      notify_timer = setTimeout(function () {
         notify
            .stop()
            .removeClass('is-show')
            .fadeOut(200, function () {
               $(this).remove();
            });
         clearTimeout(notify_timer);
      }, time);
   }

   $.notify = notify;

   window.notify = window.notify || jQuery.notify;
});