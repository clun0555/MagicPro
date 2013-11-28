define [
	"underscore"
	"Base"
	"App"
	"jquery"
	"models/Category"
	"models/Type"
	"models/Product"
], (_, Base, App, $, Category, Type, Product) ->


	@cache = new Base.Collection()
	@cache.model = Product

	# returns a collection of products by typeIdentifier
	App.reqres.setHandler "product:by:type", (typeIdentifier) ->
		job = $.Deferred()

		App.request("type:by:identifier", typeIdentifier).done (type) ->
			App.request("product:all", type: type.get("_id")).done (products) ->
				job.resolve products


		job
	

	# returns a collection of products
	App.reqres.setHandler "product:all", (query) =>

		job = $.Deferred()

		products = new Base.Collection()
		products.model = Product
		products.url = "/api/products?" + $.param(query) 
		
		$.when(
			products.fetch()
			App.request("type:all")
		).done (xhr, types) => 
			
			for product in products.models
				type = types.findWhere _id: product.get("type")
				product.set "typeIdentifier": type.get("identifier"), "categoryIdentifier": type.get("categoryIdentifier")
			
			@cache.add products.models

			# App.products = products
			job.resolve products
		.fail =>
			job.reject()

		job

	App.reqres.setHandler "product:by:identifier", (identifier) =>

		job = $.Deferred()

		$.when(
			@cache.lookup(identifier)
			App.request("type:all")
		).done (product, types) -> 
			type = types.findWhere _id: product.get("type")
			product.set "typeIdentifier": type.get("identifier"), "categoryIdentifier": type.get("categoryIdentifier")
			job.resolve product
		
		job






		
	



