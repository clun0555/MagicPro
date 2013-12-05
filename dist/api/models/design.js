(function() {
  var Design, mongoose;

  mongoose = require("mongoose");

  Design = new mongoose.Schema({
    label: String,
    identifier: String,
    imageId: String
  });

  module.exports = mongoose.model("Design", Design);

}).call(this);
