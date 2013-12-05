(function() {
  require.config({
    paths: {
      "underscore": "base/lib/underscore/underscore",
      "angular": "base/lib/angular/angular",
      "angular-route": "base/lib/angular-route/angular-route",
      "angular-resource": "base/lib/angular-resource/angular-resource",
      "angular-ui-router": "base/lib/angular-ui-router/release/angular-ui-router",
      "domReady": "base/lib/requirejs-domready/domReady"
    },
    shim: {
      "underscore": {
        exports: "_"
      },
      'angular': {
        exports: 'angular'
      },
      'angular-route': {
        deps: ['angular']
      },
      'angular-resource': {
        deps: ['angular']
      },
      'angular-ui-router': {
        deps: ['angular']
      }
    },
    deps: ['./main']
  });

}).call(this);
