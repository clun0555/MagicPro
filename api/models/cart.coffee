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

Cart.methods.sortBy = (field1, field2)->
	@bundles.sort (a, b)->
		if !a.product[field1].equals(b.product[field1])
			(a.product[field1] > b.product[field1]) - (a.product[field1] < b.product[field1])
		else
			(a.product[field2] > b.product[field2]) - (a.product[field2] < b.product[field2])


module.exports = mongoose.model("Cart", Cart)

