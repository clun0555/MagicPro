define [
	"jquery"
	"Base"
	"App"
	"models/User"

], ($, Base, App, User) ->
	
	# returns a collection of products
	App.reqres.setHandler "products:all", ->
		unless App.products?
			App.products = new Base.Collection()
			App.products.url = "/api/products"
			App.products.fetch reset: true

		App.products

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



		
	


