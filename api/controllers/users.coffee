fs = require('fs')
settings = require("../settings")
User = require("../models/user")
_ = require("underscore")
user = require("connect-roles")
email = require("../utils/email")


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

	forgot: (req, res) ->
		User.findOne { email: req.params.email },  (err, user) ->
			if err 
				res.send err
			else if not user?
				res.status(403).send "Missing user"
			else
				user.generateForgotKey ->
					user.save (err, user2) -> 
						res.send err or "ok"
						email.send 
							to: user2.email
							# cc: null
							subject: "password reset"
							text: "http://localhost:5000/#/reset/" +  user2.forgot


	userByForgotKey: (req, res) ->
		User.findOne { forgot: req.params.forgotKey },  (err, user) ->
			if err 
				res.send err
			else if not user?
				res.status(403).send("")
			else
				res.send err or user

	reset: (req, res) ->
		User.findOne { forgot: req.params.forgotKey },  (err, user) ->
			if err 
				res.send err
			else if not user?
				res.status(403).send("")
			else
				user.setPassword req.body.password, ->
					user.forgot = null
					user.save (err, user2) -> 
						res.send err or user2						



