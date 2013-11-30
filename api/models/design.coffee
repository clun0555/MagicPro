mongoose = require("mongoose")

Design = new mongoose.Schema
	label: String
	identifier: String
	imageId: String	

module.exports = mongoose.model("Design", Design)