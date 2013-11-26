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
		
		users = new Base.Collection()
		users.model = User
		users.url = "/api/users"
		users.fetch reset: true

		users

	# returns a specific user
	App.reqres.setHandler "users:get", (id) ->
		
		user = new User()
		user.id = id
		
		user.fetch()

		user



		
	


