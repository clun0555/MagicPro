mongoose = require("mongoose")

Type = new mongoose.Schema
	title: {type: String, required: true }
	description: {type: String, required: true }
	imageId: { type: String }
	identifier: {type: String, require: true, unique: true}

module.exports = mongoose.model("Type", Type)