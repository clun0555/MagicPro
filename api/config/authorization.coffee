user = require("connect-roles")

exports.setup = (app) ->
	
	user.use "anonymous", (req, action) ->
		not req.user.isAuthenticated

	user.use "registered", (req, action) ->
		req.user.isAuthenticated

	user.use "admin", (req, action) ->
		req.user.role is "admin"

	# list here all routes alowed for anonymous users
	publicRoutes = [
		"/", 
		"/api/authentification/login", 
		"/api/authentification/register"
	]

	isRegistered = user.is("registered")

	app.all "*", (req, res, next) ->
		if req.url in publicRoutes then next() else isRegistered(req, res, next)



