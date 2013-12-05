(function() {
  var app, authentification, authorization, environment, express, expressMongoose, mongoose, passport, path, resource, sessionStore, user;

  express = require("express");

  path = require("path");

  mongoose = require("mongoose");

  passport = require('passport');

  resource = require('express-resource-new');

  expressMongoose = require('express-mongoose');

  authentification = require("./controllers/authentification");

  authorization = require("./config/authorization");

  environment = require("./config/environment");

  user = require('connect-roles');

  app = express();

  mongoose.connect(environment.MONGO_URL);

  console.log("connected to " + environment.MONGO_URL);

  sessionStore = environment.getSessionStore(express, mongoose);

  app.configure(function() {
    app.use(express.compress());
    app.use(express["static"](path.join(__dirname + "/../", "public")));
    app.use(express.cookieParser());
    app.use(express.bodyParser());
    app.use(express.session({
      secret: "test",
      collection: "sessions",
      cookie: {
        maxAge: 2 * 24 * 60 * 60 * 1000
      },
      store: sessionStore
    }));
    app.use(passport.initialize());
    app.use(passport.session());
    app.use(user);
    app.use(express.methodOverride());
    app.use(app.router);
    app.set('controllers', __dirname + '/controllers');
    return app.use(express.errorHandler({
      dumpExceptions: true,
      showStack: true
    }));
  });

  authorization.setup(app);

  authentification.setup(app);

  app.resource('products');

  app.resource('users');

  app.resource('categories');

  app.resource('carts');

  app.post("/file/create", require("./controllers/files").create);

  app.listen(environment.PORT);

}).call(this);
