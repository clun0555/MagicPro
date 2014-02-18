mongoose = require("mongoose")

Article = new mongoose.Schema
	title: { type: String, required: true }
	body: { type: String }

module.exports = mongoose.model("Article", Article)