define [
	"jquery"
	"Base"
	"App"
	"models/User"
	"models/Category"
	"models/Type"
	"models/Product"

], ($, Base, App, User, Category, Type, Product) ->
	
	# returns a collection of products
	App.reqres.setHandler "products:all", ->
		unless App.products?
			App.products = new Base.Collection()
			App.products.model = Product
			App.products.url = "/api/products"
			App.products.fetch reset: true

		App.products

	# returns a collection of category
	App.reqres.setHandler "categories:all", ->
		App.categories = new Base.Collection()
		App.categories.model = Category
		App.categories.url = "/api/categories"
		App.categories.fetch reset: true

		App.categories

	# returns a collection of category
	App.reqres.setHandler "types:all", ->
		App.types = new Base.Collection()
		App.types.model = Type
		App.types.url = "/api/types"
		App.types.fetch reset: true

		App.types

	App.reqres.setHandler "types:by:identifier", (id) ->
		
		job = $.Deferred()

		# return null directly if id is null
		return job.resolve(null) unless id?
		
		type =  new Type("identifier": id)
		type.fetch().done -> job.resolve type

		job

	App.reqres.setHandler "categories:by:identifier", (id) ->
		
		job = $.Deferred()
		
		# return null directly if id is null
		return job.resolve(null) unless id?

		category = new Category("identifier": id)
		category.fetch().done -> job.resolve category
		
		job


	App.reqres.setHandler "products:by:identifier", (id) ->
		
		job = $.Deferred()
		
		# return null directly if id is null
		return job.resolve(null) unless id?

		category = new Product("identifier": id)
		category.fetch().done -> job.resolve category
		
		job


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



		
	


