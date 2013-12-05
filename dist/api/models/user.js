(function() {
  var BadRequestError, Cart, LocalStrategy, User, crypto, mongoose, options, util;

  mongoose = require('mongoose');

  util = require("util");

  crypto = require("crypto");

  LocalStrategy = require("passport-local").Strategy;

  BadRequestError = require("passport-local").BadRequestError;

  options = {
    saltlen: 32,
    iterations: 25000,
    keylen: 512,
    usernameField: "email"
  };

  Cart = require("./cart");

  User = new mongoose.Schema({
    firstname: {
      type: String,
      required: true
    },
    lastname: {
      type: String,
      required: true
    },
    email: {
      type: String,
      required: true
    },
    role: {
      type: String,
      required: true,
      "default": "user"
    },
    cart: {
      type: mongoose.Schema.Types.Mixed
    },
    imageId: {
      type: String
    },
    hash: String,
    salt: String
  });

  User.methods.setPassword = function(password, cb) {
    var _this = this;
    if (!password) {
      return cb(new BadRequestError("user.password.required"));
    }
    return crypto.randomBytes(options.saltlen, function(err, buf) {
      var salt;
      if (err) {
        return cb(err);
      }
      salt = buf.toString("hex");
      return crypto.pbkdf2(password, salt, options.iterations, options.keylen, function(err, hashRaw) {
        if (err) {
          return cb(err);
        }
        _this.set("hash", new Buffer(hashRaw, "binary").toString("hex"));
        _this.set("salt", salt);
        return cb(null, _this);
      });
    });
  };

  User.methods.authenticate = function(password, cb) {
    var _this = this;
    return crypto.pbkdf2(password, this.get("salt"), options.iterations, options.keylen, function(err, hashRaw) {
      var hash;
      if (err) {
        return cb(err);
      }
      hash = new Buffer(hashRaw, "binary").toString("hex");
      if (hash === _this.get("hash")) {
        return cb(null, _this);
      } else {
        return cb(null, false, {
          message: "user.password.incorect"
        });
      }
    });
  };

  User.methods.toJSON = function() {
    var user;
    user = this.toObject();
    delete user.salt;
    delete user.hash;
    return user;
  };

  User.statics.authenticate = function() {
    var _this = this;
    return function(username, password, cb) {
      return _this.findByUsername(username, function(err, user) {
        if (err) {
          return cb(err);
        }
        if (user) {
          return user.authenticate(password, cb);
        } else {
          return cb(null, false, {
            message: "user.username.incorrect"
          });
        }
      });
    };
  };

  User.statics.serializeUser = function() {
    return function(user, cb) {
      return cb(null, user.get(options.usernameField));
    };
  };

  User.statics.deserializeUser = function() {
    var _this = this;
    return function(username, cb) {
      return _this.findByUsername(username, cb);
    };
  };

  User.statics.register = function(user, password, cb) {
    if (!(user instanceof this)) {
      user = new this(user);
    }
    if (!user.get(options.usernameField)) {
      return cb(new BadRequestError("user.username.required"));
    }
    return this.findByUsername(user.get(options.usernameField), function(err, existingUser) {
      if (err) {
        return cb(err);
      }
      if (existingUser) {
        return cb(new BadRequestError("user.username.existing"));
      }
      return user.setPassword(password, function(err, user) {
        if (err) {
          return cb(err);
        }
        return user.save(function(err) {
          if (err) {
            return cb(err);
          }
          return cb(null, user);
        });
      });
    });
  };

  User.statics.findByUsername = function(username, cb) {
    var query, queryParameters;
    queryParameters = {};
    queryParameters[options.usernameField] = username;
    query = this.findOne(queryParameters);
    return query.exec(cb);
  };

  module.exports = mongoose.model('User', User);

}).call(this);
