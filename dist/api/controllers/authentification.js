(function() {
  var LocalStrategy, User, passport;

  passport = require('passport');

  LocalStrategy = require('passport-local').Strategy;

  User = require('../models/user');

  passport.use(new LocalStrategy(User.authenticate()));

  passport.serializeUser(User.serializeUser());

  passport.deserializeUser(User.deserializeUser());

  exports.setup = function(app) {
    app.post("/api/authentification/register", function(req, res) {
      req.logout();
      return User.register(new User({
        email: req.body.email,
        firstname: req.body.firstname,
        lastname: req.body.lastname
      }), req.body.password, function(err, user) {
        if (!err) {
          return req.login(user, function() {
            return res.redirect("/api/authentification/currentuser");
          });
        } else {
          return res.status(401).send(err.message);
        }
      });
    });
    app.post("/api/authentification/login", passport.authenticate("local"), function(req, res) {
      return res.redirect("/api/authentification/currentuser");
    });
    app.get("/api/authentification/currentuser", function(req, res) {
      return res.send(req.user);
    });
    return app.get("/api/authentification/logout", function(req, res) {
      req.logout();
      return res.redirect("/api/authentification/currentuser");
    });
  };

}).call(this);
