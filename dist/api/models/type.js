(function() {
  var Type, mongoose;

  mongoose = require("mongoose");

  Type = new mongoose.Schema({
    imageId: {
      type: String
    },
    title: {
      type: String,
      required: true
    },
    slug: {
      type: String,
      required: true,
      unique: true
    },
    description: {
      type: String
    }
  });

  module.exports = mongoose.model("Type", Type);

}).call(this);
