passport = require('passport')
mongoose = require("mongoose")

exports.setup = (app) ->

	Type = new mongoose.Schema
		title: {type: String, required: true }
		description: {type: String, required: true }

	TypeModel = mongoose.model("Type", Type)

	app.get "/api/Types", (req, res) ->
		TypeModel.find (err, types) ->
			unless err
				res.send types
			else
				console.log err

	app.post "/api/types", (req, res) ->

		type = new TypeModel
			title: req.body.title
			description: req.body.description



		type.save()

		res.send type

	app.get "/api/types/:id", (req, res) ->
		TypeModel.findById req.params.id, (err, type) ->
			unless err
				res.send type
			else
				console.log err


	app.put "/api/types/:id", (req, res) ->
		TypeModel.findById req.params.id, (err, type) ->

			type.title = req.body.title

			type.save (err) ->
				unless err
					console.log "updated"
				else
					console.log err

				res.send type



	app.del "/api/types/:id", (req, res) ->
		TypeModel.findById req.params.id, (err, type) ->
			type.remove (err) ->
				unless err
					console.log "removed"
					res.send ""
				else
					console.log err


