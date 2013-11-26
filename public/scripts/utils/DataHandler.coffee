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
	# App.reqres.setHandler "products:all", ->
	# 	unless App.products?
	# 		App.products = new Base.Collection()
	# 		App.products.model = Product
	# 		App.products.url = "/api/products"
	# 		App.products.fetch reset: true

	# 	App.products


	# # returns a collection of category
	# App.reqres.setHandler "categories:all", ->
		
	# 	# return job if already declared
	# 	return App.job if App.job?

	# 	App.job = $.Deferred()

	# 	categories = new Base.Collection()
	# 	categories.model = Category
	# 	categories.url = "/api/categories"
	# 	categories.fetch().done -> 
	# 		App.categories = categories
	# 		App.job.resolve App.categories

	# 	App.job

	# # returns a collection of category
	# App.reqres.setHandler "categories:all", ->
	# 	job = $.Deferred()

	# 	if App.categories?
	# 		job.resolve(App.categories) 
	# 	else
	# 		categories = new Base.Collection()
	# 		categories.model = Category
	# 		categories.url = "/api/categories"
	# 		categories.fetch().done -> 
	# 			App.categories = categories
	# 			job.resolve App.categories

	# 		job

		

	# returns a collection of category
	# App.reqres.setHandler "types:all", ->
	# 	App.types = new Base.Collection()
	# 	App.types.model = Type
	# 	App.types.url = "/api/types"
	# 	App.types.fetch reset: true

	# 	App.types

	# App.reqres.setHandler "types:by:identifier", (id) ->
		
	# 	job = $.Deferred()

	# 	# return null directly if id is null
	# 	return job.resolve(null) unless id?
		
	# 	type =  new Type("identifier": id)
	# 	type.fetch().done -> job.resolve type

	# 	job

	# App.reqres.setHandler "categories:by:identifier", (id) ->
		
	# 	job = $.Deferred()

	# 	# return null directly if id is null
	# 	return job.resolve(null) unless id?

	# 	App.request("categories:all").done (categories) ->
	# 		job.resolve categories.findWhere { identifier: id }	
		
	# 	# category = new Category("identifier": id)
	# 	# category.fetch().done -> job.resolve category
			
	# 	job	

	



	# App.reqres.setHandler "products:by:identifier", (id) ->
		
	# 	job = $.Deferred()
		
	# 	# return null directly if id is null
	# 	return job.resolve(null) unless id?

	# 	category = new Product("identifier": id)
	# 	category.fetch().done -> job.resolve category
		
	# 	job


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



		
	


