mongoose = require("mongoose")

Type = new mongoose.Schema
	title: {type: String, required: true }
	description: {type: String, required: true }

module.exports = mongoose.model("Type", Type)