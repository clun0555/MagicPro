(function() {
  define(["./module"], function(directives) {
    "use strict";
    return directives.directive("appVersion", [
      "version", function(version) {
        return function(scope, elm) {
          return elm.text(version);
        };
      }
    ]);
  });

}).call(this);
