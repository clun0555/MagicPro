mongoose = require("mongoose")
Design = require("./design")

Product = new mongoose.Schema
	identifier: {type: String, required: true }
	slug: {type: String, require: true, unique: true}
	title: { type: String, required: true }
	description: { type: String }
	imageId: { type: String }
	type: {type: mongoose.Schema.ObjectId, ref: 'Type'}
	designs: [ Design.schema ]
	size: {type: String }
	inner: { type: Number }
	modified: { type: Date, default: Date.now }

module.exports = mongoose.model("Product", Product)

