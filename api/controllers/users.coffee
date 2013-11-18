fs = require('fs')
settings = require("../settings")
User = require("../models/user")
_ = require("underscore")
user = require("connect-roles")


isOwner = (req, res, next) ->
	if req.user.is("admin") or req.params.user is req.user.email
		next()
	else
		res.status(403).send("")

module.exports = 

	options: 
		name: 'api/users'
		id: 'user'
		before: 
			index: user.is("admin")
			destroy: user.is("admin")
			create: user.is("admin")
			show: isOwner
			update: isOwner
	
	index: (req, res) ->
		res.send User.find()

	show: (req, res) ->
		res.send User.findById req.params.user

	create: (req, res) ->

		user = new User _.extend({}, req.body)
		
		user.save (err, user) -> res.send err or user
			
	update: (req, res) ->
		User.findById req.params.user,  (err, user) ->
			if err 
				res.send err
			else if not user?
				res.send "Missing user"
			else
				_.extend user, req.body
				user.save (err, user) -> res.send err or user			

	destroy: (req, res) ->
		res.send User.findByIdAndRemove req.params.user
