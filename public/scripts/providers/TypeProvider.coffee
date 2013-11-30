define [
	"underscore"
	"Base"
	"App"
	"jquery"
	"models/Category"
	"models/Type"
	"models/Product"
], (_, Base, App, $, Category, Type, Product) ->



	App.reqres.setHandler "type:all", ->

		job = $.Deferred()

		App.request("category:all")
			.done (categories) ->
				types = _.chain(categories.pluck("types")).pluck("models").flatten().value()
				job.resolve new Base.Collection(types)
			.fail ->
				job.reject [ 404, "Type #{id} not found" ]
		
		job	

	# uses cached category list to retrieve a specific category
	App.reqres.setHandler "type:by:category", (slug) ->
		
		job = $.Deferred()

		# fail if id is null
		return job.reject() unless slug?

		App.request("category:by:slug", slug)
			.done ( category ) ->
				if category? 
					job.resolve category.get("types")
				else 
					job.reject [ 404, "Category #{id} not found" ]
			.fail ->
				job.reject [ 404, "Category #{id} not found" ]

		job
	

	App.reqres.setHandler "type:by:id", (id) ->

		job = $.Deferred()

		# fail if id is null
		return job.reject() unless id?

		App.request("type:all")
			.done (types) ->
				type = types.findWhere { _id: id }
				if type? then job.resolve type else job.reject [ 404, "Type #{id} not found" ]
			.fail ->
				job.reject [ 404, "Type #{id} not found" ]
		
		job

	App.reqres.setHandler "type:by:slug", (slug) ->

		job = $.Deferred()

		# fail if slug is null
		return job.reject() unless slug?

		App.request("type:all")
			.done (types) ->
				type = types.findWhere { slug: slug }
				if type? then job.resolve type else job.reject [ 404, "Type #{slug} not found" ]
			.fail ->
				job.reject [ 404, "Type #{slug} not found" ]
		
		job	