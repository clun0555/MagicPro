passport = require('passport')
LocalStrategy = require('passport-local').Strategy
User = require('../models/user')
user = require("connect-roles")

passport.use new LocalStrategy(User.authenticate())
passport.serializeUser User.serializeUser()
passport.deserializeUser User.deserializeUser()

exports.setup = (app) ->

	app.post "/api/authentification/register", (req, res) ->
		req.logout()
		User.register(
			new User(email: req.body.email, firstname: req.body.firstname, lastname: req.body.lastname)
			req.body.password
			(err, user) -> 
				unless err
					req.login user, -> res.redirect "/api/authentification/currentuser"
				else
					res.status(401).send(err.message)

		)

	app.post "/api/authentification/login", passport.authenticate("local"), (req, res) ->
		res.redirect "/api/authentification/currentuser"
		

	app.get "/api/authentification/currentuser", user.is("registered"), (req, res) ->
		res.send req.user

	app.get "/api/authentification/logout", user.is("registered"), (req, res) ->
		req.logout()
		res.redirect "/api/authentification/currentuser"
