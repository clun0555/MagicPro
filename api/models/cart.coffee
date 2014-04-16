mongoose = require("mongoose")
Product = require("./product")

Cart = new mongoose.Schema
	created: { type: Date, default: Date.now }
	price: { type: Number }
	quantity: { type: Number }
	user: {type: mongoose.Schema.ObjectId, ref: 'User'}
	method: { type: String}
	note: { type: String}

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
			price += bundle.product.price * bundle.product.inner * composition.quantity
	price

Cart.methods.sortBy = (field)->
	@bundles.sort (a, b)->
		(a.product[field] > b.product[field]) - (a.product[field] < b.product[field])


module.exports = mongoose.model("Cart", Cart)

