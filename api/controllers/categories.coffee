Category = require("../models/category")
_ = require("underscore")

module.exports = 

	options: 
		name: 'api/categories'
		id: 'category'
	
	index: (req, res) ->
		res.send Category.find()

	show: (req, res) ->
		res.send Category.findById req.params.category

	create: (req, res) ->

		category = new Category _.extend({}, req.body)
		
		category.save (err, category) -> res.send err or category
			
	update: (req, res) ->
		Category.findById req.params.category,  (err, category) ->
			if err 
				res.send err
			else if not category?
				res.send "Missing category"
			else
				_.extend category, req.body
				category.save (err, category) -> res.send err or category

	destroy: (req, res) ->
		res.send Category.findByIdAndRemove req.params.category		