passport = require('passport')
LocalStrategy = require('passport-local').Strategy
User = require('../models/user')
user = require("connect-roles")
_ = require("underscore")


passport.use new LocalStrategy(User.authenticate())
passport.serializeUser User.serializeUser()
passport.deserializeUser User.deserializeUser()

exports.setup = (app) ->

	app.post "/api/authentification/register", (req, res) ->
		req.logout()
		userData = req.body

		# force role to user and status to pending for security
		userData = _.extend userData, role: "user", status: "pending"
		
		User.register(
			new User(userData)
			req.body.password
			(err, user) -> 
				unless err
					req.login user, -> res.redirect "/api/authentification/currentuser"
				else
					res.status(401).send(err.message)

		)

	app.post "/api/authentification/login", (req, res, next) ->		
		passport.authenticate("local", (err, user, info) ->		
			
			return res.status(401).send(err.message) if err 

			return res.status(401).send(info?.message) unless user

			req.logIn user, (err) ->
				return next(err) if err
				res.redirect "/api/authentification/currentuser"
		
		)(req, res, next)

	app.get "/api/authentification/currentuser", user.is("registered"), (req, res) ->
		res.send req.user

	app.get "/api/authentification/logout", user.is("registered"), (req, res) ->
		req.logout()
		res.redirect "/api/authentification/currentuser"
