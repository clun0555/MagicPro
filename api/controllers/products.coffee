Product = require("../models/product")
_ = require("underscore")
user = require("connect-roles")
s3 = require("../utils/s3")



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
		
		product.save (err, product) -> 
			if err
				res.status(400).send err
			else
				res.send err or product
			
	update: (req, res) ->
		Product.findById req.params.product,  (err, product) ->
			if err 
				res.send err
			else if not product?
				res.send "Missing product"
			else
				
				oldDesigns = product.designs
				_.extend product, req.body
				# product.designs = oldDesigns

				for design in oldDesigns 
					stillExists = _.findWhere(req.body.designs, {'_id': design.id})?					
					unless stillExists
						# product.designs.push design
						design.remove()

				product.save (err, product) -> 
					if err
						res.status(400).send err					
					else
						res.send product					
				

				

	destroy: (req, res) ->
		res.send Product.findByIdAndRemove req.params.product		