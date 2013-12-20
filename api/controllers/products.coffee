Product = require("../models/product")
_ = require("underscore")
user = require("connect-roles")

module.exports = 

	options: 
		name: 'api/products'
		id: 'product'

	all: (req, res, next) ->
		user.is("registered")(req, res, next)
	
	index: (req, res) ->
		if req.query?
			if req.query.advanced?
				res.send Product.find JSON.parse(req.query.advanced)
			else
				res.send Product.find req.query
		else
			res.send Product.find()

	show: (req, res) ->
		res.send Product.findById req.params.product

	create: (req, res) ->

		product = new Product _.extend({}, req.body)
		
		product.save (err, product) -> res.send err or product
			
	update: (req, res) ->
		Product.findById req.params.product,  (err, product) ->
			if err 
				res.send err
			else if not product?
				res.send "Missing product"
			else
				_.extend product, req.body
				product.save (err, product) -> res.send err or product			

	destroy: (req, res) ->
		res.send Product.findByIdAndRemove req.params.product		