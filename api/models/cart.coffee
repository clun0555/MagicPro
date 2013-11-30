mongoose = require("mongoose")
Product = require("./product")

Cart = new mongoose.Schema
	created: { type: Date, default: Date.now }
	price: { type: Number }
	quantity: { type: Number }
	user: {type: mongoose.Schema.ObjectId, ref: 'User'}
	bundles: [{
		product: { type: mongoose.Schema.Types.Mixed }
		compositions: [{
			design: { type: mongoose.Schema.ObjectId, required: true, ref: 'Design' }
			quantity: { type: Number, required: true }
		}]
	}]

module.exports = mongoose.model("Cart", Cart)

