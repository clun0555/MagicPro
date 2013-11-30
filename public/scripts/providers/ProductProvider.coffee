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
	@jobs = {}

	# returns a collection of products by typeSlug

	App.reqres.setHandler "product:by:type", (typeSlug) ->
		
		job = $.Deferred()

		App.request("type:by:slug", typeSlug).done (type) ->
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
			
			@cache.add products.models
			
			job.resolve products
		.fail =>
			job.reject()

		job

	App.reqres.setHandler "product:by:slug", (slug) =>
		return @jobs[slug] if @jobs[slug]?

		@jobs[slug] = $.Deferred() 

		@cache.lookup(slug: slug).done (product) =>
			
			@jobs[slug].resolve product
		
		@jobs[slug]






		
	



