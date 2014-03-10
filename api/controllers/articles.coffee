Article = require("../models/article")
_ = require("underscore")
user = require("connect-roles")

module.exports = 

	options: 
		name: 'api/articles'
		id: 'article'
		before: 
			destroy: user.is("admin")
			create: user.is("admin")
			update: user.is("admin")
	
	# all: (req, res, next) ->
	# 	user.is("registered")(req, res, next)

	index: (req, res) ->
		res.send Article.find()

	show: (req, res) ->
		res.send Article.findById req.params.article

	create: (req, res) ->

		article = new Article _.extend({}, req.body)
		
		article.save (err, article) -> res.send err or article
			
	update: (req, res) ->
		Article.findById req.params.article,  (err, article) ->
			if err 
				res.send err
			else if not article?
				res.send "Missing article"
			else
				_.extend article, req.body
				article.save (err, article) -> res.send err or article

	destroy: (req, res) ->
		res.send Article.findByIdAndRemove req.params.article		