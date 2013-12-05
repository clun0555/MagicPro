(function() {
  define(["require", "angular", "app", "routes"], function(require, ng) {
    return require(["domReady!"], function(document) {
      return ng.bootstrap(document, ["app"]);
    });
  });

}).call(this);
