(function() {
  var url, _;

  url = require('url');

  _ = require('underscore');

  /*
  	Extension of node's standard url module
  */


  module.exports = {
    parse: function(href) {
      var path, _ref;
      path = url.parse(href);
      if (path.auth != null) {
        _ref = path.auth.split(':'), path.login = _ref[0], path.password = _ref[1];
      }
      return path;
    },
    format: function(path) {
      if ((path.login != null) && (path.password != null)) {
        path.auth = path.login + ":" + path.password;
      }
      return url.format(path);
    },
    process: function(path) {
      if (!((path.href != null) || (path.hostname != null))) {
        return false;
      }
      if ((path.protocol == null) && (path.href == null)) {
        return false;
      }
      if (path.href != null) {
        return _.extend(path, this.parse(path.href));
      } else {
        path.href = this.format(path);
        return path;
      }
    }
  };

}).call(this);
