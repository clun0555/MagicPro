passport = require('passport')
mongoose = require("mongoose")

exports.setup = (app) ->

	Category = new mongoose.Schema
		title: {type: String, required: true }
		description: {type: String, required: true }

	CategoryModel = mongoose.model("Category", Category)

	app.get "/api/Categories", (req, res) ->
		CategoryModel.find (err, categories) ->
			unless err
				res.send categories
			else
				console.log err

	app.post "/api/categories", (req, res) ->

		category = new CategoryModel
			title: req.body.title
			description: req.body.description



		category.save()

		res.send category

	app.get "/api/categories/:id", (req, res) ->
		CategoryModel.findById req.params.id, (err, category) ->
			unless err
				res.send category
			else
				console.log err


	app.put "/api/categories/:id", (req, res) ->
		CategoryModel.findById req.params.id, (err, category) ->

			category.title = req.body.title

			category.save (err) ->
				unless err
					console.log "updated"
				else
					console.log err

				res.send category



	app.del "/api/categories/:id", (req, res) ->
		CategoryModel.findById req.params.id, (err, category) ->
			category.remove (err) ->
				unless err
					console.log "removed"
					res.send ""
				else
					console.log err


