(function() {
  // This needs to be called via RequireJS because it contains a define(),
  // otherwise we'd have a "Mistmatched anonymous define() modules" error.
  // See http://requirejs.org/docs/errors.html
  window.require.config({
    paths: {
      'moengage': 'https://cdn.moengage.com/webpush/moe_webSdk.min.latest'
    },
  });
  window.require(['moengage'],
    function() {
      Moengage = moe({
        app_id: 'ZU04WET9EDMIAID17FJV2BKW',
        debug_logs: 0
      });
    }
  );
})();
