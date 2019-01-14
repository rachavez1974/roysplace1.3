(function ($, Drupal) {
  Drupal.behaviors.gr8istNavbarSticky = {
    attach: function (context, settings) {
      var $stickyNavbarWrapper = $('.sticky-navbar-wrapper').first();
      var navbarTop = $stickyNavbarWrapper.offset().top;

      var isDesktop = false;
      if (window.innerWidth > 767) {
        isDesktop = true;
      }

      var $navbarsWrapper = $stickyNavbarWrapper.find('.navbars-wrapper');
      var $stickyNavbar = $navbarsWrapper.find('.sticky-navbar');
      var requestAnimationFrame = window.requestAnimationFrame ||
                                  window.webkitRequestAnimationFrame ||
                                  window.mozRequestAnimationFrame ||
                                  window.msRequestAnimationFrame ||
                                  window.oRequestAnimationFrame;
      var topShareTop = $('.top-share:first').offset().top;
      var stickyNavbarsAreShowing = false;
      var stickyNavbarIsShowing = false;
      var initScroll = 0;
      var $adminMenu = $('.slicknav_menu');
      if ($adminMenu.length) {
        initScroll = $adminMenu.height();
      }

      // Mobile
      var $navbarForMobile = $navbarsWrapper.find('header[role="banner"]');
      var navbarsWrapperTop = $navbarsWrapper.offset().top;
      $navbarForMobile.addClass('sticky-enabled');
      var lastScrollTop = $(window).scrollTop();
      var navbarShowing = true;
      var initScroll = 0;

      var loop = function() {
        var scrollTop = $(window).scrollTop();

        // Stick all navbars (only leaderboard on mobile)
        if (scrollTop <= navbarTop) {
          if (stickyNavbarsAreShowing) {
            $stickyNavbarWrapper.removeClass('stick');
            stickyNavbarsAreShowing = false;
          }
        }
        else {
          if (!stickyNavbarsAreShowing) {
            $stickyNavbarWrapper.addClass('stick');
            stickyNavbarsAreShowing = true;
          }
        }

        if (isDesktop) {
          // Shows white sticky navbar on article (desktop only)
          if (scrollTop <= topShareTop) {
            if (stickyNavbarIsShowing) {
              $stickyNavbar.removeClass('show');
              stickyNavbarIsShowing = false;
            }
          }
          else {
            if (!stickyNavbarIsShowing) {
              $stickyNavbar.addClass('show');
              stickyNavbarIsShowing = true;
            }
          }
        }
        else {
          // Shows black sticky navbar on article when scrolling up (mobile only)
          if (scrollTop <= navbarsWrapperTop) {
            $navbarForMobile.removeClass('in-article');
            $navbarForMobile.removeClass('sticky');
          }
          else if (scrollTop > topShareTop) {
            if (lastScrollTop > scrollTop) {
              if (!navbarShowing) {
                $navbarForMobile.addClass('in-article');
                $navbarForMobile.addClass('sticky');
              }
              navbarShowing = true;
            }
            else if (lastScrollTop < scrollTop) {
              if (navbarShowing) {
                $navbarForMobile.addClass('in-article');
                $navbarForMobile.removeClass('sticky');
              }
              navbarShowing = false;
            }
          }
          lastScrollTop = scrollTop;
        }

        requestAnimationFrame(loop);
      };

      if (requestAnimationFrame) {
        loop();
      }


      // Sticky leaderboard
      var $leaderboard = $stickyNavbarWrapper.find('.leaderboard');
      var leaderboardStickTime = 2;

      function stickLeaderboard() {
        if (!isDesktop) {
          navbarsWrapperTop = $navbarsWrapper.offset().top;
        }

        // Refreshes the position of top share buttons (for the white sticky nav bar)
        topShareTop = $('.top-share:first').offset().top;

        // Unstick after leaderboardStickTime seconds
        setTimeout(function() {
          // Transition
          if ($stickyNavbar.hasClass('show')) {
            $stickyNavbar.css('padding-top', $leaderboard.height() + 'px').delay(80).animate({ 'padding-top': 0 }, 400, 'linear');
          }

          $stickyNavbarWrapper.addClass('unstick-leaderboard');
          if (isDesktop) {
            navbarTop = $leaderboard.offset().top + $leaderboard.height();
          }
          else {
            navbarTop = $stickyNavbarWrapper.offset().top;
            navbarsWrapperTop = $navbarsWrapper.offset().top;
          }
        }, leaderboardStickTime);
      }

      // Init leaderboard ad
      leaderboardStickTime = 0;
      if (isDesktop) {
        leaderboardStickTime = parseInt($stickyNavbarWrapper.data('time-desktop')) * 1000;
      }
      else {
        leaderboardStickTime = parseInt($stickyNavbarWrapper.data('time-mobile')) * 1000;
      }
      if (leaderboardStickTime) {
        if ($stickyNavbarWrapper.hasClass('enable-sticky-leaderboard-ad')) {
          stickLeaderboard();
        }
        else {
          $stickyNavbarWrapper.on('enable-sticky-leaderboard-ad', function() {
            stickLeaderboard();
            $stickyNavbarWrapper.off('enable-sticky-leaderboard-ad');
          });
        }
      }
    }
  }
})(jQuery, Drupal);
