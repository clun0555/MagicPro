passport = require('passport')
mongoose = require("mongoose")

exports.setup = (app) ->
	
	Product = new mongoose.Schema
		title: { type: String, required: true }
		description: { type: String, required: true }
		style: { type: String, unique: true }
		modified: { type: Date, default: Date.now }
	
	ProductModel = mongoose.model("Product", Product)
	
	app.get "/api/products", (req, res) ->
		ProductModel.find (err, products) ->
			unless err
				res.send products
			else
				console.log err

	app.post "/api/products", (req, res) ->
		
		product = new ProductModel
			title: req.body.title
			description: req.body.description
			style: req.body.style
		
		product.save()

		res.send product

	app.get "/api/products/:id", (req, res) ->
		ProductModel.findById req.params.id, (err, product) ->
			unless err
				res.send product
			else
				console.log err


	app.put "/api/products/:id", (req, res) ->
		ProductModel.findById req.params.id, (err, product) ->
			
			product.title = req.body.title
			product.description = req.body.description
			product.style = req.body.style
			
			product.save (err) ->
				unless err
					console.log "updated"
				else
					console.log err
				
				res.send product



	app.del "/api/products/:id", (req, res) ->
		ProductModel.findById req.params.id, (err, product) ->
			product.remove (err) ->
				unless err
					console.log "removed"
					res.send ""
				else
					console.log err


