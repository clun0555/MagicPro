passport = require('passport')
User = require('../models/user')

exports.setup = (app) ->

	app.post "/api/register", (req, res) ->
		req.logout()
		User.register(
			new User(username: req.body.username, firstname: req.body.firstname, lastname: req.body.lastname)
			req.body.password
			(err, user) -> 
				unless err
					req.login user, -> res.redirect "/api/currentuser"		
				else
					res.status(401).send(err.message)

		)

	app.post "/api/login", passport.authenticate("local"), (req, res) ->
		res.redirect "/api/currentuser"
		

	app.get "/api/currentuser", (req, res) ->
		res.send req.user

	app.get "/api/logout", (req, res) ->
		req.logout()
		res.redirect "/api/currentuser"
