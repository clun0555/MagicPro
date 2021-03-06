mongoose = require("mongoose")
Design = require("./design")
FilePlugin = require("../utils/FilePlugin")
SlugPlugin = require("../utils/SlugPlugin")

Product = new mongoose.Schema
	identifier: {type: String, required: true, unique: true }
	title: { type: String, required: true }
	description: { type: String }
	type: {type: mongoose.Schema.ObjectId, ref: 'Type'}
	designs: [ Design.schema ]
	size: {type: String }
	inner: { type: Number, require: true }
	modified: { type: Date, default: Date.now }
	price: {type: Number, require: true}
	featured: {type: Boolean}

Product.plugin(FilePlugin, {fields: ["image"]})
Product.plugin(SlugPlugin.plugin, {source: 'title'})

ProductModel = mongoose.model("Product", Product)

SlugPlugin.enhanceModel(ProductModel)

module.exports = ProductModel

