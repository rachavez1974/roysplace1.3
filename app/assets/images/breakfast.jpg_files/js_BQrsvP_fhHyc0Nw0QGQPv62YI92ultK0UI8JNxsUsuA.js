// Allow other JavaScript libraries to use $.
jQuery.noConflict();

(function ($) {
  Drupal.behaviors.gr8ist30DayHack = {
    attach: function(context) {
      $('.sticky-navbar-wrapper .navbar-menu-overlay-content ul:nth-of-type(2) .first').removeClass('first');
      $('.sticky-navbar-wrapper .navbar-menu-overlay-content ul:nth-of-type(2)').prepend(Drupal.settings.Gr8ist30DaysHack.menuItem);
    }
  };
  

})(jQuery);;
