(function ($, Drupal) {
  Drupal.behaviors.gr8istNavbarSocial = {
    attach: function (context, settings) {
      var $mainMenu = $('#main-menu', context);

      if ($mainMenu.length) {
        $mainMenu.once('gr8istNavbarSocial').each(function () {
          // Newsletter Check: if not already subscribed,
          // the newletter entry field shows up on the navbar on large + x-large screens
          var cookieSubscribedKey = 'greatist-subscribed-to-newsletter';
          if (document.cookie.indexOf(cookieSubscribedKey) === -1) {
            var $navbarNewsletter = $mainMenu.find('.newsletter-block');
            if ($navbarNewsletter.length) {
              $navbarNewsletter.show();
            }
          }

          // Menu Overlay
          var $menuButton = $mainMenu.find('.navbar-menu-cta');
          if ($menuButton.length) {
            var $menuOverlay = $mainMenu.find('.navbar-menu-overlay');
            $menuButton.click(function () {
              if ($menuOverlay.hasClass('show')) {
                $menuOverlay.removeClass('show');
                $mainMenu.removeClass('navbar-menu-opened');
              }
              else {
                if (window.greatist) {
                  var greatist = window.greatist;
                  if (greatist.scrapeScreenSize() === 'medium') {
                    greatist.trackClickEvent('followus-nav');
                  }
                }
                $menuOverlay.addClass('show');
                $mainMenu.addClass('navbar-menu-opened');
              }
            });
            $menuOverlay.find('.navbar-menu-overlay-content-close').click(function() {
              $menuOverlay.removeClass('show');
              $mainMenu.removeClass('navbar-menu-opened');
            });
          }

          // Social Tracking on navbar (Tablet only)
          function trackSocial(network, target) {
            if ('greatist' in window) {
              greatist.trackSocialEvent(network, 'navigation-like', target);
            }
          }

          var $pinterestCTA = $mainMenu.find('.social-group-pinterest .social-cta');
          $pinterestCTA.click(function () {
            trackSocial('Pinterest', 'https://www.pinterest.com/greatist/pins/follow/?guid=a429Y0Rjbavm');
          });
          var $instagramCTA = $mainMenu.find('.social-group-instagram .social-cta');
          $instagramCTA.click(function () {
            trackSocial('Instagram', 'https://www.instagram.com/greatist/?ref=badge');
          });
        });
      }
    }
  }
})(jQuery, Drupal);
