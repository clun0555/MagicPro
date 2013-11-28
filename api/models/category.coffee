mongoose = require("mongoose")
Type = require("./type")

Category = new mongoose.Schema
		title: {type: String, required: true }
		description: {type: String, required: true }
		identifier: {type: String, require: true, unique: true}
		types: [Type.schema]

module.exports = mongoose.model("Category", Category)

