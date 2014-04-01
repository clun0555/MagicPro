mongoose = require("mongoose")
FilePlugin = require("../utils/FilePlugin")

Article = new mongoose.Schema
	title: { type: String, required: true }
	content: { type: String }
	status: { type: String }
	category: { type: String }
	createdOn: { type: Date, default: -> new Date() }

Article.plugin(FilePlugin, {fields: ["image"]})

module.exports = mongoose.model("Article", Article)