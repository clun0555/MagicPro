define [
	"./services"
	"underscore"
], (services, _) ->	

	services.service "ShopService", ($resource, $q) ->

		Products = $resource "/api/products/:id", { "_id": "@id"}, { 'update': {method:'PUT'} }

		search:
			title: ""

		flushState: ->
			@search.title = ""
		
		getCategories: ->
			deferred = $q.defer()

			if @categories?
				deferred.resolve categories: @categories
			else
				categories = $resource("api/categories").query =>
					@categories = categories
					deferred.resolve categories: @categories

			deferred.promise

		getCategoryBySlug: (categorySlug) ->
			deferred = $q.defer()
			
			@getCategories().then (data) ->
				category = _.findWhere data.categories, {slug: categorySlug}
				if category?
					for type in category.types
						products = $resource("api/products?type=#{type._id}").query ->
						type.products = products
						deferred.resolve category: category
				else
					deferred.reject { code: 404 }

			deferred.promise

		getTypeBySlug: (categorySlug, typeSlug) ->
			deferred = $q.defer()

			@getCategoryBySlug(categorySlug).then(
				
				(data) ->
					type = _.findWhere data.category.types, {slug: typeSlug}
					
					return deferred.reject { code: 404 } unless type?
					
					type.category = data.category				
					deferred.resolve type: type, category: data.category
				
				(data) -> deferred.reject data

			)

			deferred.promise		

		getTypeById: (typeId) ->
			deferred = $q.defer()

			@getCategories().then(
				
				(data) ->

					category = _.find data.categories, (category) -> _.findWhere(category.types, "_id": typeId )
					return deferred.reject { code: 404 } unless category?

					type = _.findWhere(category.types, "_id": typeId)
					type.category = category			
					deferred.resolve type: type, category: category
				
				(data) -> deferred.reject data

			)

			deferred.promise		

		getProductsByCategoryTypeSlug: (categorySlug, typeSlug) ->
			deferred = $q.defer()
			
			@getTypeBySlug(categorySlug, typeSlug).then( 
				(data) ->
					products = $resource("api/products?type=#{data.type._id}").query ->
						product.type = data.type for product in products
						deferred.resolve products: products, type: data.type, category: data.type.category
				
				(data) -> deferred.reject data
			)


			deferred.promise

		getProductBySlug: (categorySlug, typeSlug, productSlug) ->
			
			deferred = $q.defer()
			
			products = $resource("api/products?slug=#{productSlug}").query =>
				return deferred.reject { code: 404 } if products.length is 0

				product = products[0]

				product.inner = 1 if !product.inner

				@getTypeBySlug(categorySlug, typeSlug, productSlug).then (data) ->
					product.type = data.type
					deferred.resolve product: product, type: product.type, category: product.type.category

			
			deferred.promise

		getProductById: (productId) ->
			
			deferred = $q.defer()
			
			products = $resource("api/products/?_id=#{productId}").query =>
				return deferred.reject { code: 404 } if products.length is 0

				product = products[0]

				@getTypeById(product.type).then (data) ->
					product.type = data.type
					deferred.resolve product: product, type: product.type, category: product.type.category

			
			deferred.promise

		getProductsByIds: (productIds) ->
			
			deferred = $q.defer()

			advanced = "_id": "$in": productIds

			products = $resource("api/products?advanced=#{JSON.stringify(advanced)}").query =>
				
				# fetch types for all products
				typeIds = 
					for product in products
						do (product) =>
							@getTypeById(product.type).then( (data) -> product.type = data.type )

				$q.all(typeIds).then ->
					console.log products
					deferred.resolve(products)
				
			
			deferred.promise

		saveProduct: (product) ->

			if product._id?
				Products.update( { id: product._id }, product).$promise
			else
				Products.save( { }, product).$promise
