mongoose = require("mongoose")
Product = require("./product")

Cart = new mongoose.Schema
	created: { type: Date, default: Date.now }
	price: { type: Number }
	quantity: { type: Number }
	user: {type: mongoose.Schema.ObjectId, ref: 'User'}
	bundles: [{
		product: { type: mongoose.Schema.ObjectId, ref: 'Product' }
		compositions: [{
			design: { type: mongoose.Schema.ObjectId, required: true, ref: 'Design' }
			quantity: { type: Number, required: true }
		}]
	}]


Cart.methods.totalPrice = ->
	price = 0
	for bundle in @bundles
		for composition in bundle.compositions
			price += bundle.product.price * composition.quantity
	price


module.exports = mongoose.model("Cart", Cart)

