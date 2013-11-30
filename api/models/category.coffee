mongoose = require("mongoose")
Type = require("./type")

Category = new mongoose.Schema
	title: {type: String, required: true }
	slug: {type: String, require: true, unique: true}
	description: { type: String }
	imageId: { type: String }
	types: [Type.schema]


module.exports = mongoose.model("Category", Category)

