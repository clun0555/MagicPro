Type = require("../models/type")
_ = require("underscore")

module.exports = 

	options: 
		name: 'api/types'
		id: 'type'
	
	index: (req, res) ->
		res.send Type.find()

	show: (req, res) ->
		res.send Type.findOne identifier: req.params.type

	create: (req, res) ->

		type = new Type _.extend({}, req.body)
		
		type.save (err, type) -> res.send err or type
			
	update: (req, res) ->
		Type.findById req.params.type,  (err, type) ->
			if err 
				res.send err
			else if not type?
				res.send "Missing type"
			else
				_.extend type, req.body
				type.save (err, type) -> res.send err or type

	destroy: (req, res) ->
		res.send Type.findByIdAndRemove req.params.type		