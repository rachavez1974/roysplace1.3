(function ($) {
  Drupal.behaviors.greatistPromotionPopup = {
    attach: function (context, settings) {
      var cookie_name = settings.greatist_promotion.popup_cookie_name;

      // Is this the popup for the Daily NL? This only works if the Promo entity
      // is given the exact title of "Daily Popup".
      var is_daily = cookie_name === "greatist-promo-daily-popup";
      // There are multiple promo unit types for the Daily NL and a different
      // cookie is used to indicate if the user has subscribed to it.
      var daily_cookie_name = "greatist-subscribed-to-newsletter";

      function getCookie(cookiename) {
        // Get name followed by anything except a semicolon
        var cookiestring=RegExp(""+cookiename+"[^;]+").exec(document.cookie);
        // Return everything after the equal sign, or an empty string if the cookie name not found
        return decodeURIComponent(!!cookiestring ? cookiestring.toString().replace(/^[^=]+./,"") : "");
      }

      function setCookie(name,value,days) {
        var expires = "";
        if (days) {
          var date = new Date();
          date.setTime(date.getTime() + (days*24*60*60*1000));
          expires = "; expires=" + date.toUTCString();
        }
        document.cookie = name + "=" + (value || "")  + expires + "; path=/";
      }

      function hidePopup($element) {
        // Hide the promo by un-checking the invisible checkbox field, the label
        // for which serves as the close icon.
        $('#toggle').prop('checked', false);

        if ($element.length > 0) {
          $element.css('opacity', 0);
          $element.css('display', "none");
          $element.css('z-index', -1);
        }
      }

      $(document).ready(function ($) {
        // Check the cookie to determine if this user has engaged with the popup
        // before. Or, if this is the daily popup, check if the user already
        // subscribed. If so don't do anything except make sure hide_popup is
        // false.
        if (getCookie(cookie_name) || (is_daily && getCookie(daily_cookie_name))) {
          settings.greatist_promotion.hide_popup = false;
          return false;
        }
        settings.greatist_promotion.hide_popup = true;

        // The pagemask covers the entire viewport and dims the background
        // behind the popup modal.
        var $pagemask = $('.promo-popup-pagemask');

        // Make the popup visible after some seconds, where N is pulled from the
        // config in Drupal.settings.
        setTimeout(function () {
          // Show the promo by checking the invisible checkbox field.
          $('#toggle').prop('checked', true);

          // Dim the background by making the pagemask element visible.
          if ($pagemask.length > 0) {
            $pagemask.css('opacity', 100);
            $pagemask.css('z-index', 998);
          }

          // Fire this but on a 2 second delay to give time for the
          // 'became-visible' event callback to register.
          setTimeout(function () {
            $('.promo-popup .message').trigger('became-visible');
          }, 2000);
        }, settings.greatist_promotion.popup_delay);

        // We configured a custom event to trigger in newsletter-ctrl.js upon
        // newsletter form submission success.
        $(document).on('promo-popup-submit-success', function (e) {
          setCookie(cookie_name, 1, 30);

          // Set a cookie to indicate that the user has subscribed to the Daily
          // Newsletter. This will prevent other promo units for the Daily NL
          // from being shown to the user.
          if (is_daily) {
            setCookie(daily_cookie_name, 1, 30);
          }

          hidePopup($pagemask);
        });

        // Dismiss the popup and pagemask when clicking anywhere on the pagemask
        // outside of the popup modal.
        $pagemask.on('click', function (event) {
          // Was the click outside of the popup modal?
          if (this === event.target) {
            setCookie(cookie_name, 1, 30);
            hidePopup($pagemask);
          }
          else {
            // Prevent the firing of the pagemask's GA tracking event when the
            // click occurs inside the popup modal.
            event.stopImmediatePropagation();
          }
        });

        // Dismiss the popup when clicking on either the close button or the
        // click-through link.
        $('#toggle, .promo-popup .message a').on('click', function (event) {
          // Avoid doing anything when clicking on the form input elements.
          if (event.target.type === 'email' || event.target.type === 'submit') {
            return;
          }

          // Otherwise, set a cookie and dismiss the popup.
          setCookie(cookie_name, 1, 30);
          hidePopup($pagemask);
        });
      });
    }
  };
})(jQuery);
;
/**
 * @file Common data layer helper.
 */

(function ($) {
  Drupal.behaviors.dataLayer = {

    /**
     * The language prefix list (no blank).
     *
     * @return {array}
     */
    langPrefixes: function langPrefixes() {
      var languages = Drupal.settings.dataLayer.languages,
          langList = [];

      for (var lang in languages) {
        if (languages[lang].prefix !== '') {
          langList.push(languages[lang].prefix);
        }
      }
      return langList;

      // With Underscore.js dependency.
      //var list = _.pluck(Drupal.settings.datalayer.languages, 'prefix');
      //return _.filter(list, function(lang) { return lang });
    },

    /**
     * Drupal behavior.
     */
    attach: function() { return }

  };
})(jQuery);
;
