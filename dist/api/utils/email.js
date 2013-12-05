(function() {
  var environment, nodemailer, smtpTransport, _;

  nodemailer = require("nodemailer");

  _ = require("underscore");

  environment = require("../config/environment");

  smtpTransport = nodemailer.createTransport("SMTP", {
    host: environment.SMTP_HOST,
    port: environment.SMTP_PORT,
    auth: {
      user: environment.SMTP_LOGIN,
      pass: environment.SMTP_PASSWORD
    }
  });

  exports.send = function(options) {
    options = _.defaults(options, {
      from: environment.EMAIL_FROM,
      cc: environment.EMAIL_CC
    });
    return smtpTransport.sendMail(options, function(error, response) {
      if (error) {
        return console.log(error);
      } else {
        return console.log("Message sent: " + response.message);
      }
    });
  };

}).call(this);
