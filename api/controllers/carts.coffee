Cart = require("../models/cart")
User = require("../models/user")
_ = require("underscore")
email = require("../utils/email")
json2csv = require('json2csv')
user = require("connect-roles")

module.exports = 

	options: 
		name: 'api/carts'
		id: 'cart'

	all: (req, res, next) ->
		user.is("registered")(req, res, next)
	
	index: (req, res) ->
		res.send Cart.find()

	show: (req, res) ->
		res.send Cart.findOne _id: req.params.cart

	create: (req, res) ->

		cart = new Cart _.extend({}, req.body)
		
		cart.save (err, cart) -> 
			return res.send err if err?

			sendConfirmationEmail(cart, req.user)
			
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



sendConfirmationEmail = (cart, user) ->
	cartJSON = cart.toJSON()
	designs = []


	cart.populate "bundles.product", =>

		for bundle in cart.bundles
			for composition in bundle.compositions
				# bundle.populate("product")
				design = _.findWhere(bundle.product.designs, { id:  composition.design.toJSON()  })
				designs.push 
					"itemId": bundle.product.identifier 
					"designId": design.identifier
					"quantity": composition.quantity
					"unitPrice": bundle.product.price


		json2csv { data: designs, fields: ['itemId', 'designId', 'quantity', 'unitPrice'], fieldNames: ['Item Id', 'Design Id', 'Quantity', 'Unit Price'] } , (err, csv) ->
			
			options = {
				subject: "Magic Pro Order",
				text: csv
				to: user.email
				attachments: [{
					fileName: "order.csv"
					contents: csv
				}]
			}

			email.send (options)
			