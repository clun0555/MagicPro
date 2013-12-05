(function() {
  var User, fs, isOwner, settings, user, _;

  fs = require('fs');

  settings = require("../settings");

  User = require("../models/user");

  _ = require("underscore");

  user = require("connect-roles");

  isOwner = function(req, res, next) {
    if (req.user.is("admin") || req.params.user === req.user.email) {
      return next();
    } else {
      return res.status(403).send("");
    }
  };

  module.exports = {
    options: {
      name: 'api/users',
      id: 'user',
      before: {
        index: user.is("admin"),
        destroy: user.is("admin"),
        create: user.is("admin"),
        show: isOwner,
        update: isOwner
      }
    },
    index: function(req, res) {
      return res.send(User.find());
    },
    show: function(req, res) {
      return res.send(User.findById(req.params.user));
    },
    create: function(req, res) {
      user = new User(_.extend({}, req.body));
      return user.save(function(err, user) {
        return res.send(err || user);
      });
    },
    update: function(req, res) {
      return User.findById(req.params.user, function(err, user) {
        if (err) {
          return res.send(err);
        } else if (user == null) {
          return res.send("Missing user");
        } else {
          _.extend(user, req.body);
          return user.save(function(err, user) {
            return res.send(err || user);
          });
        }
      });
    },
    destroy: function(req, res) {
      return res.send(User.findByIdAndRemove(req.params.user));
    }
  };

}).call(this);
