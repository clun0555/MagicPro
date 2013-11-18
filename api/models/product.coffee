mongoose = require("mongoose")

Product = new mongoose.Schema
	item_id: {type: String, required: true }
	color_id: {type: String, required: false }
	color: {type: String, required: false }
	title: { type: String, required: false }
	description: { type: String, required: false }
	inner: { type: Number, unique: false}
	modified: { type: Date, default: Date.now }
	imageId: { type: String }

module.exports = mongoose.model("Product", Product)

