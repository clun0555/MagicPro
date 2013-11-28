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
				for category in categories.models
					for type in category.get("types")
						type.categoryIdentifier = category.get("identifier")						

				App.categories = categories
				job.resolve App.categories
			.fail =>
				job.reject()

		job

	# uses cached category list to retrieve a specific category
	App.reqres.setHandler "category:by:identifier", (id) ->
		
		job = $.Deferred()

		# fail if id is null
		return job.reject() unless id?

		App.request("category:all")
			.done (categories) ->
				category = categories.findWhere { identifier: id }
				if category? then job.resolve category else job.reject [ 404, "Category #{id} not found" ]
			.fail ->
				job.reject [ 404, "Category #{id} not found" ]
		
		job	