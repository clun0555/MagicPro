Cart = require("../models/cart")
_ = require("underscore")
email = require("../utils/email")
json2csv = require('json2csv')

module.exports = 

	options: 
		name: 'api/carts'
		id: 'cart'
	
	index: (req, res) ->
		res.send Cart.find()

	show: (req, res) ->
		res.send Cart.findOne _id: req.params.cart

	create: (req, res) ->

		cart = new Cart _.extend({}, req.body)
		
		cart.save (err, cart) -> 
			return res.send err if err?
			
			cartJSON = cart.toJSON()
			designs = []

			for bundle in cart.bundles
				for composition in bundle.compositions
					design = _.findWhere(bundle.product.designs, { _id:  composition.design.toJSON()  })
					designs.push 
						"itemId": bundle.product.identifier 
						"designId": design.identifier
						"quantity": composition.quantity
						"unitPrice": bundle.product.price


			json2csv { data: designs, fields: ['itemId', 'designId', 'quantity', 'unitPrice'], fieldNames: ['Item Id', 'Design Id', 'Quantity', 'Unit Price'] } , (err, csv) ->
				
				options = {
					from: "My Name <me@example.com>", # sender address
					to: "Your Name <romaric.laurent@gmail.com>", # comma separated list of receivers
					subject: "Hello ✔", # Subject line
					text: csv
					attachments: [{
						fileName: "order.csv"
						contents: csv
					}]
				}

				email.send (options)
			
			res.send cart
			
	update: (req, res) ->
		Cart.findById req.params.cart,  (err, cart) ->
			if err 
				res.send err
			else if not cart?
				res.send "Missing cart"
			else
				_.extend cart, req.body
				cart.save (err, cart) -> res.send err or cart

	destroy: (req, res) ->
		res.send Cart.findByIdAndRemove req.params.cart		