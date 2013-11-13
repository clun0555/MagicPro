passport = require('passport')
mongoose = require("mongoose")

exports.setup = (app) ->

	Product = new mongoose.Schema
		item_id: {type: String, required: true }
		color_id: {type: String, required: false }
		color: {type: String, required: false }
		title: { type: String, required: false }
		description: { type: String, required: false }
		inner: { type: Number, unique: false}
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
			item_id: req.body.item_id
			color_id: req.body.color_id
			color: req.body.color
			title: req.body.title
			description: req.body.description
			inner: req.body.inner


		
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

			product.item_id = req.body.item_id
			product.color_id = req.body.color_id
			product.color = req.body.color
			product.title = req.body.title
			product.description = req.body.description
			product.inner = req.body.inner

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


