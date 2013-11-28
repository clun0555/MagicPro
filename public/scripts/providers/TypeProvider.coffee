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
				types = _.chain(categories.pluck("types")).flatten().value()
				job.resolve new Base.Collection(types)
			.fail ->
				job.reject [ 404, "Type #{id} not found" ]
		
		job	

	# uses cached category list to retrieve a specific category
	App.reqres.setHandler "type:by:category", (identifier) ->
		
		job = $.Deferred()

		# fail if id is null
		return job.reject() unless identifier?

		App.request("category:by:identifier", identifier)
			.done ( category ) ->
				if category? 
					collection = new Base.Collection()
					collection.model = Type
					collection.add category.get("types")
					model.set "categoryIdentifier", category.id for model in collection.models
					job.resolve collection
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

	App.reqres.setHandler "type:by:identifier", (identifier) ->

		job = $.Deferred()

		# fail if identifier is null
		return job.reject() unless identifier?

		App.request("type:all")
			.done (types) ->
				type = types.findWhere { identifier: identifier }
				if type? then job.resolve type else job.reject [ 404, "Type #{identifier} not found" ]
			.fail ->
				job.reject [ 404, "Type #{identifier} not found" ]
		
		job	