(function() {
  var mongoose;

  mongoose = require("mongoose");

  mongoose.connect(process.env.MONGOHQ_URL || "mongodb://localhost/ecomm_database");

}).call(this);
