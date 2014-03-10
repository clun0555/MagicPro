mongoose = require("mongoose")

Article = new mongoose.Schema
	title: { type: String, required: true }
	content: { type: String }
	createdOn: { type: Date, default: -> new Date() }

module.exports = mongoose.model("Article", Article)