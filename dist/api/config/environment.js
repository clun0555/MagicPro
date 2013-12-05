(function() {
  var config, local, path, url, _;

  _ = require("underscore");

  url = require("../utils/url");

  config = {
    PORT: process.env.PORT,
    S3_KEY: process.env.S3_KEY,
    S3_SECRET: process.env.S3_SECRET,
    S3_BUCKET: process.env.S3_BUCKET,
    MONGO_URL: process.env.MONGO_URL || process.env.MONGOHQ_URL,
    MONGO_LOGIN: process.env.MONGO_LOGIN,
    MONGO_PASSWORD: process.env.MONGO_PASSWORD,
    MONGO_HOSTNAME: process.env.MONGO_HOSTNAME,
    MONGO_PORT: process.env.MONGO_PORT,
    MONGO_DATABASE: process.env.MONGO_DATABASE,
    REDIS_URL: process.env.REDIS_URL || process.env.REDISTOGO_URL,
    REDIS_HOSTNAME: process.env.REDIS_HOSTNAME,
    REDIS_DATABASE: process.env.REDIS_DATABASE,
    REDIS_PASSWORD: process.env.REDIS_PASSWORD,
    REDIS_PORT: process.env.REDIS_PORT,
    IMAGE_SERVER_PATH: process.env.IMAGE_SERVER_PATH,
    SESSION_STORE: process.env.SESSION_STORE,
    SMTP_HOST: process.env.SMTP_HOST,
    SMTP_PORT: process.env.SMTP_PORT,
    SMTP_LOGIN: process.env.SMTP_LOGIN,
    SMTP_PASSWORD: process.env.SMTP_PASSWORD,
    EMAIL_FROM: process.env.EMAIL_FROM,
    EMAIL_CC: process.env.EMAIL_CC
  };

  try {
    local = require("../../config/environment");
    config = _.extend(config, local);
  } catch (_error) {}

  config = _.defaults(config, {
    PORT: 3000,
    SESSION_STORE: "MONGO"
  });

  path = url.process({
    protocol: "redis",
    href: config.REDIS_URL,
    login: config.REDIS_DATABASE,
    password: config.REDIS_PASSWORD,
    hostname: config.REDIS_HOSTNAME,
    port: config.REDIS_PORT,
    slashes: true
  });

  config.REDIS_URL = path.href;

  config.REDIS_DATABASE = path.login;

  config.REDIS_PASSWORD = path.password;

  config.REDIS_HOSTNAME = path.hostname;

  config.REDIS_PORT = path.port;

  path = url.process({
    protocol: "mongodb",
    href: config.MONGO_URL,
    hostname: config.MONGO_HOSTNAME,
    password: config.MONGO_PASSWORD,
    port: config.MONGO_PORT,
    login: config.MONGO_LOGIN,
    pathname: config.MONGO_DATABASE,
    slashes: true
  });

  config.MONGO_URL = path.href;

  config.MONGO_LOGIN = path.login;

  config.MONGO_PASSWORD = path.password;

  config.MONGO_HOSTNAME = path.hostname;

  config.MONGO_PORT = path.port;

  config.MONGO_DATABASE = path.pathname;

  config.getSessionStore = function(express, mongoose) {
    var MongoStore, RedisStore, options;
    switch (config.SESSION_STORE) {
      case "MONGO":
        MongoStore = require('connect-mongo')(express);
        return new MongoStore({
          db: mongoose.connection.db
        });
      case "REDIS":
        RedisStore = require('connect-redis')(express);
        options = config.REDIS_HOSTNAME != null ? {
          host: config.REDIS_HOSTNAME,
          port: config.REDIS_PORT,
          db: config.REDIS_DATABASE,
          pass: config.REDIS_PASSWORD
        } : {};
        return new RedisStore(options);
      default:
        return new express.session.MemoryStore;
    }
  };

  module.exports = config;

}).call(this);
