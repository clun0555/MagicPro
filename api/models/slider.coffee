mongoose = require("mongoose")
Type = require("./type")

Slider = new mongoose.Schema
  title: {type: String, required: true }
  order: { type: Number }



module.exports = mongoose.model("Slider", Slider)

