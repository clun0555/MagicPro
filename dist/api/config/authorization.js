(function() {
  var user,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  user = require("connect-roles");

  exports.setup = function(app) {
    var isRegistered, publicRoutes;
    user.use("anonymous", function(req, action) {
      return !req.user.isAuthenticated;
    });
    user.use("registered", function(req, action) {
      return req.user.isAuthenticated;
    });
    user.use("admin", function(req, action) {
      return req.user.role === "admin";
    });
    publicRoutes = ["/", "/api/authentification/login", "/api/authentification/register"];
    isRegistered = user.is("registered");
    return app.all("*", function(req, res, next) {
      var _ref;
      if (_ref = req.url, __indexOf.call(publicRoutes, _ref) >= 0) {
        return next();
      } else {
        return isRegistered(req, res, next);
      }
    });
  };

}).call(this);
