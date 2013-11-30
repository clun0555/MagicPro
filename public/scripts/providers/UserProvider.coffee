define [
	"jquery"
	"Base"
	"App"
	"models/User"
	"models/Category"
	"models/Type"
	"models/Product"

], ($, Base, App, User, Category, Type, Product) ->
	
	# returns a collection of users
	App.reqres.setHandler "users:all", ->
		job = $.Deferred()

		users = new Base.Collection()
		users.model = User
		users.url = "/api/users"
		
		users.fetch success: =>
			job.resolve users

		job

	# returns a specific user
	App.reqres.setHandler "users:get", (id) ->
		job = $.Deferred()

		user = User.find id
		return job.resolve user if user?

		user = new User()
		user.id = id
		
		user.fetch success: =>
			job.resolve user

		job



		
	


