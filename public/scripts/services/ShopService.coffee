define [
	"./module"
	"underscore"
], (services, _) ->	

	services.service "ShopService", ($resource, $q) ->
		
		getCategories: ->
			deferred = $q.defer()

			# if @categories?
			# 	deferred.resolve categories: @categories
			# else

			@categories = $resource("api/categories").query =>
				deferred.resolve categories: @categories

			deferred.promise

		getCategoryBySlug: (categorySlug) ->
			deferred = $q.defer()
			
			@getCategories().then (data) ->
				category = _.findWhere data.categories, {slug: categorySlug}
				deferred.resolve category: category

			deferred.promise

		getTypeBySlug: (categorySlug, typeSlug) ->
			deferred = $q.defer()

			@getCategoryBySlug(categorySlug).then (data) ->
				type = _.findWhere data.category.types, {slug: typeSlug}
				type.category = data.category
				deferred.resolve type: type, category: data.category

			deferred.promise		

		getProductsByCategoryTypeSlug: (categorySlug, typeSlug) ->
			deferred = $q.defer()
			
			@getTypeBySlug(categorySlug, typeSlug).then (data) ->
				products = $resource("api/products?type=#{data.type._id}").query ->
					product.type = data.type for product in products
					deferred.resolve products: products, type: data.type, category: data.type.category

			deferred.promise

		getProductBySlug: (categorySlug, typeSlug, productSlug) ->
			
			deferred = $q.defer()
			
			products = $resource("api/products?slug=#{productSlug}").query =>
				product = products[0]

				@getTypeBySlug(categorySlug, typeSlug, productSlug).then (data) ->
					product.type = data.type
					deferred.resolve product: product, type: product.type, category: product.type.category

			
			deferred.promise
