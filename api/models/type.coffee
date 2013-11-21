mongoose = require("mongoose")

Type = new mongoose.Schema
	title: {type: String, required: true }
	description: {type: String, required: true }
	identifier: {type: String, require: true, unique: true}

module.exports = mongoose.model("Type", Type)