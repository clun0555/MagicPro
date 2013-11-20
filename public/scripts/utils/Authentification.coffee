define [
	"jquery"
	"Base"
	"App"
	"models/User"
], ($, Base, App, User) ->
	
	# returns the current loggedin user
	App.reqres.setHandler "user", -> App.user

	# checks on server if user if loggedin, if yes populates App.user
	# performed once before application starts
	App.reqres.setHandler "user:loggedin", ->
		job = $.Deferred()
		user = new User()
		user.url = "/api/authentification/currentuser"
		user.fetch().done(-> App.user = user).always(-> job.resolve())
		job

	# performs login with username/password in userdata
	App.reqres.setHandler "user:login", (userData, forward) ->
		App.user = null
		user = new User userData
		user.url = "/api/authentification/login"

		user.save().done -> 
			App.user = user
			App.vent.trigger "user:loggedin"
			
			if forward
				# TODO can generate problems later
				App.execute forward[0], forward[1], [forward[2], forward[3], forward[4]]
			else
				App.execute "application:controller", "root"


	# performs logout
	App.reqres.setHandler "user:logout", (userData) ->
		App.user = null
		user = new User()
		user.url = "/api/authentification/logout"

		user.fetch().fail -> 
			# /api/authentification/logout currently returns a 401
			App.vent.trigger "user:loggedout"
			App.execute "application:controller", "root"

	# register a user
	App.reqres.setHandler "user:register", (userData) ->
		App.user = null
		user = new User userData
		user.url = "/api/authentification/register"

		user.save().done -> 
			App.user = user
			App.vent.trigger "user:loggedin"





		
	


