Product = require("../models/product")
_ = require("underscore")

module.exports = 

	options: 
		name: 'api/products'
		id: 'product'
	
	index: (req, res) ->
		if req.query.type?
			res.send Product.find {type: req.query.type}
		else
			res.send Product.find()

	show: (req, res) ->
		res.send Product.findOne identifier: req.params.product

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