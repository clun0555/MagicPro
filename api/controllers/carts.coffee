Cart = require("../models/cart")
User = require("../models/user")
_ = require("underscore")
email = require("../utils/email")
json2csv = require('json2csv')
user = require("connect-roles")
environment = require("../config/environment")

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
	designs = []


	cart.populate "bundles.product", =>

		cartJSON = cart.toJSON()

		cartJSON.price = cart.totalPrice()

		for bundle in cartJSON.bundles
			bundle.product.formatedPrice = "$" + bundle.product.price
			for composition in bundle.compositions
				design = _.find bundle.product.designs, (design) -> design._id.toJSON() is composition.design.toJSON()
				composition.design = design
				designs.push 
					"itemId": bundle.product.identifier 
					"designId": design.identifier
					"quantity": composition.quantity
					"unitPrice": bundle.product.price

		
		# send mail to customer
		email.send 
			subject: "MagicPro Order Confirmation",
			data: 
				cart: cartJSON
				user: user
			template: "clientorder"
			to:  user.email
			cc: null

		json2csv { data: designs, fields: ['itemId', 'designId', 'quantity', 'unitPrice'], fieldNames: ['Item Id', 'Design Id', 'Quantity', 'Unit Price'] } , (err, csv) ->
			
			# send mail to magicpro 
			email.send 
				subject: "Order Confirmation",
				data: 
					cart: cartJSON
					user: user
				template: "clientorder"
				attachments: [{
					fileName: "order.csv"
					contents: csv
				}]
				to = environment.EMAIL_FROM						
				cc: null
			