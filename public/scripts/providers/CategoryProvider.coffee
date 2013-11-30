define [
	"underscore"
	"Base"
	"App"
	"jquery"
	"models/Category"
	"models/Type"
	"models/Product"
], (_, Base, App, $, Category, Type, Product) ->
	
	App.reqres.setHandler "category:all", ->
		
		job = $.Deferred()

		return job.resolve App.categories if App.categories?

		categories = new Base.Collection()
		categories.model = Category
		categories.url = "/api/categories"
		categories.fetch()
			.done => 
				
				App.categories = categories
				job.resolve App.categories
			.fail =>
				job.reject()

		job

	# uses cached category list to retrieve a specific category
	App.reqres.setHandler "category:by:slug", (slug) ->
		
		job = $.Deferred()

		# fail if id is null
		return job.reject() unless slug?

		App.request("category:all")
			.done (categories) ->
				category = categories.findWhere { slug: slug }
				if category? then job.resolve category else job.reject [ 404, "Category #{slug} not found" ]
			.fail ->
				job.reject [ 404, "Category #{slug} not found" ]
		
		job	