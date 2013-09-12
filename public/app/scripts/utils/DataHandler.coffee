define [
  "jquery"
	"Base"
	"App"
	"models/User"

], ($, Base, App, User) ->

	# returns a collection of products
	App.reqres.setHandler "products:all", ->
		App.collection = new Base.Collection()
		App.collection.url = "/api/products"
		App.collection.fetch reset: true

		App.collection

	# returns a collection of category
	App.reqres.setHandler "categories:all", ->
		App.collection = new Base.Collection()
		App.collection.url = "/api/categories"
		App.collection.fetch reset: true

		App.collection

	# returns a collection of category
	App.reqres.setHandler "types:all", ->
		App.collection = new Base.Collection()
		App.collection.url = "/api/types"
		App.collection.fetch reset: true

		App.collection

	# returns the current loggedin user
	App.reqres.setHandler "user", -> App.user

	# checks on server if user if loggedin, if yes populates App.user
	# performed once before application starts
	App.reqres.setHandler "user:loggedin", ->
		job = $.Deferred()
		user = new User()
		user.url = "/api/currentuser"
		user.fetch().done(-> App.user = user).always(-> job.resolve())
		job

	# performs login with username/password in userdata
	App.reqres.setHandler "user:login", (userData) ->
		App.user = null
		user = new User userData
		user.url = "/api/login"

		user.save().done ->
			App.user = user
			App.vent.trigger "user:loggedin"

	# performs logout
	App.reqres.setHandler "user:logout", (userData) ->
		App.user = null
		user = new User()
		user.url = "/api/logout"

		user.fetch().fail ->
			# /api/logout currently returns a 401
			App.vent.trigger "user:loggedout"

	# register a user
	App.reqres.setHandler "user:register", (userData) ->
		App.user = null
		user = new User userData
		user.url = "/api/register"

		user.save().done ->
			App.user = user
			App.vent.trigger "user:loggedin"







