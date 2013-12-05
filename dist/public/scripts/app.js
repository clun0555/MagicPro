/*
loads sub modules and wraps them up into the main module
this should be used for top-level module definitions only
*/


(function() {
  define(["angular", "angular-route", "angular-resource", "angular-ui-router", "controllers/index", "directives/index", "filters/index", "services/index"], function(angular) {
    return angular.module("app", ["app.controllers", "app.directives", "app.filters", "app.services", "ngRoute", "ngResource", "ui.router"]);
  });

}).call(this);
