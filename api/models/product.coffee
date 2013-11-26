mongoose = require("mongoose")

Product = new mongoose.Schema
	item_id: {type: String, required: true }
	color_id: {type: String, required: false }
	size: {type: String, required: false }
	color: {type: String, required: false }
	title: { type: String, required: false }
	description: { type: String, required: false }
	inner: { type: Number, unique: false}
	modified: { type: Date, default: Date.now }
	imageId: { type: String }
	identifier: {type: String, require: true, unique: true}
	type: {type: mongoose.Schema.ObjectId, ref: 'Type'}
	designs: [
		{ label: String, designId: String, imageId: String }
	]

module.exports = mongoose.model("Product", Product)

