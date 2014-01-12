mongoose = require("mongoose")
FilePlugin = require("../utils/FilePlugin")

Design = new mongoose.Schema
	label: String
	identifier: String
	imageId: String	

Design.plugin(FilePlugin, {fields: ["image"]})

module.exports = mongoose.model("Design", Design)