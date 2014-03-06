fs = require('fs')
settings = require("../settings")
User = require("../models/user")
_ = require("underscore")
user = require("connect-roles")
email = require("../utils/email")
environment = require("../config/environment")


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
		if req.query?
			if req.query.advanced?
				res.send User.find JSON.parse(req.query.advanced)
			else
				res.send User.find req.query
		else
			res.send User.find()

	show: (req, res) ->
		res.send User.findById req.params.user

	create: (req, res) ->

		user = new User _.extend({}, req.body)
		
		user.save (err, user) -> res.send err or user
			
	update: (req, res) ->
		User.findById req.params.user,  (err, user) ->
			oldStatus = user.status
			if err 
				res.status(400).send err
			else if not user?
				res.status(400).send "Missing user"
			else
				_.extend user, req.body
				user.save (err, user) -> 
					if err
						res.status(400).send err
					else
						res.send user
						if oldStatus in ["pending", "rejected"] and user.status is "validated"
							email.send 
								to: user.email
								cc: null
								subject: "Your signup request has been granted"
								template: "uservalidated"
								data: 
									user: user
									homePage: environment.DOMAIN
					


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
							cc: null
							subject: "MagicPro Password Reset"
							template: "passwordreset"
							data: 
								resetLink: environment.DOMAIN + "/#/reset/" + user2.forgot
								user: user


	userByForgotKey: (req, res) ->
		User.findOne { forgot: req.params.forgotKey },  (err, user) ->
			if err 
				res.send err
			else if not user?
				res.status(403).send("")
			else
				res.send err or user

	# 2 ways to reset password
	#    - forgotKey + new password
	# or - email, current password, new password
	reset: (req, res) ->
		if req.params.forgotKey? and req.body.currentPassword? and req.body.newPassword

			User.findOne { email: req.params.forgotKey },  (err, user) ->
				if err 
					res.send err
				else if not user?
					res.status(403).send("")
				else 
					user.authenticate req.body.currentPassword, (err, user, errKey) ->
						return res.status(403).send(err) if err?
						return res.status(403).send(errKey) if errKey?

						user.setPassword req.body.newPassword, ->
							user.forgot = null
							user.setPassword req.body.newPassword, ->
								user.save (err, user2) -> res.send err or user2

		else if req.params.forgotKey

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
		else
			res.status(403).send("Missing parameters")						



