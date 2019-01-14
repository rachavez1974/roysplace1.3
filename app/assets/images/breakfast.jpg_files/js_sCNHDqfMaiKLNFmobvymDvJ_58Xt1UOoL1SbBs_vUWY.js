(function ($, Drupal) {
  Drupal.behaviors.gr8istAdsAdvertisers = {
    attach: function(context, settings) {
      function loadAdvertiserScript(url) {
        var scr = document.createElement("script");
        scr.setAttribute('language', 'javascript');
        scr.type = "text/javascript";
        scr.src = url;
        var node = document.getElementsByTagName("script")[0];
        node.parentNode.insertBefore(scr, node);
      }

      var $advertisersWrapper = $('.advertisers-wrapper');
      if ($advertisersWrapper.length) {
        var $outbrainWrapper = $advertisersWrapper.find('.outbrain-wrapper');
        var $zergnetWrapper = $advertisersWrapper.find('.zergnet-wrapper');
        var showOutbrain = false;
        var showZergnet = false;
        var format = $advertisersWrapper.attr('data-format');
        var trackingPrefix = 'recirculartion';
        if (format === 'list') {
          trackingPrefix = 'article-sidebar';
        }

        // If ZergNet isn't showing up for any reason, we show Outbrain (if enabled in the config).

        // Screen & probability check
        var screen = '';
        var prob = '';
        if (window.innerWidth <= 767) {
          screen = 'mobile';
          prob = $advertisersWrapper.attr('data-prob-mobile');
        }
        else if (window.innerWidth <= 979) {
          screen = 'tablet';
          prob = $advertisersWrapper.attr('data-prob-tablet');
        }
        else {
          screen = 'desktop';
          prob = $advertisersWrapper.attr('data-prob-desktop');
        }
        prob = parseFloat(prob) / 100;

        if ($outbrainWrapper.length && $zergnetWrapper.length) {
          if (Math.random() >= prob) {
            showZergnet = true;
          }
          else {
            showOutbrain = true;
          }
        }
        else if ($outbrainWrapper.length) {
          showOutbrain = true;
        }
        else if ($zergnetWrapper.length) {
          showZergnet = true;
        }

        // Force-show a specific advertiser
        if ((Math.random() >= prob) && ($zergnetWrapper.length)) {
          showZergnet = true;
        }
        else {
          showOutbrain = true;
        }

        // Referrer Check
        var search = window.location.search;
        if (search.indexOf('test-advertiser-outbrain') >= 0) {
          showOutbrain = true;
        }
        else if (search.indexOf('test-advertiser-zergnet') >= 0) {
          showZergnet = true;
        }
        else if (search.indexOf('test-advertiser-none') >= 0) {
          showOutbrain = false;
          showZergnet = false;
        }

        var trackingLabel = '';
        // Rendering for specific advertiser
        if (showZergnet) {
          var $zergnetWidget = $zergnetWrapper.find('.zergnet-widget');
          var zergnetWidgetId = $zergnetWidget.attr('id');
          zergnetWidgetId = zergnetWidgetId.replace('zergnet-widget-', '');
          loadAdvertiserScript('https://www.zergnet.com/zerg.js?id=' + zergnetWidgetId);
          trackingLabel = trackingPrefix + '-zergnet';
        }
        else if (showOutbrain) {
          // if (screen == 'mobile') {
          //   var outbrainWidget = $outbrainWrapper.find('.outbrain-widget');
          //   console.log(outbrainWidget);
          //   outbrainWidget.attr('data-widget-id', 'MB_4');
          // }
          loadAdvertiserScript('https://widgets.outbrain.com/outbrain.js');
          trackingLabel = trackingPrefix + '-outbrain';
        }

        // Track
        var options = {
          eventCategory: 'behavior',
          eventAction: 'open',
          eventLabel: trackingLabel,
          nonInteraction: true
        }
        window.ga('send', 'event', options);
      }
    }
  }
})(jQuery, Drupal);
;
