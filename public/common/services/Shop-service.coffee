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
					# @categories = categories
					@categories = _.sortBy(categories, "order")


					# reverse link to a types category
					for category in categories
						type.category = category for type in category.types

					deferred.resolve categories: @categories

			deferred.promise

		getCategoryBySlug: (categorySlug) ->
			deferred = $q.defer()
			
			@getCategories().then (data) ->
				category = _.findWhere data.categories, {slug: categorySlug}
				if category?
					# for type in category.types
					# 	products = $resource("api/products?type=#{type._id}").query ->
					# 	type.products = products
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

		# getProductsByCategoryTypeSlug: (categorySlug, typeSlug) ->
		# 	deferred = $q.defer()
			
		# 	@getTypeBySlug(categorySlug, typeSlug).then( 
		# 		(data) ->
		# 			products = $resource("api/products?type=#{data.type._id}").query ->
		# 				product.type = data.type for product in products
		# 				deferred.resolve products: products, type: data.type, category: data.type.category
				
		# 		(data) -> deferred.reject data
		# 	)


		# 	deferred.promise

		getProductsByCategoryTypeSlug: (categorySlug, typeSlug) ->
			
			deferred = $q.defer()
			
			@getTypeBySlug(categorySlug, typeSlug).then (data) =>

				type = data.type
				
				@getAllProducts().then (d2) =>

					products = d2.products
					categories = d2.categories

					products = _.filter products, (product) -> product.type.slug is typeSlug
					deferred.resolve(products: products, type: type, category: type.category)					
					
			deferred.promise

		getProductBySlug: (categorySlug, typeSlug, productSlug) ->
			deferred = $q.defer()
			
			@getAllProducts().then (data) =>

				product = _.find data.products, (product) -> product.slug is productSlug
				
				deferred.resolve(product: product, type: product.type, category: product.type.category)					
					
			deferred.promise


		getProductsById: (productId) ->
			
			deferred = $q.defer()
			
			@getAllProducts().then (data) =>

				product = _.find data.products, (product) -> product._id is productId
				
				deferred.resolve(product: product, type: product.type, category: product.type.category)					
					
			deferred.promise

		searchProduct: (productTitle) ->

			deferred = $q.defer()

			products = $resource("api/products/?search=#{productTitle}").query =>

				# fetch types for all products
				typeIds =
					for product in products
						do (product) =>
							@getTypeById(product.type).then( (data) -> product.type = data.type )

				$q.all(typeIds).then ->
					deferred.resolve products: products

			deferred.promise

		getProductsByIds: (productIds) ->
			
			deferred = $q.defer()
			
			@getAllProducts().then (data) =>

				products = _.filter data.products, (product) -> product._id in productIds
				
				deferred.resolve(products)					
					
			deferred.promise

		getProductsByCategorySlug: (categorySlug) ->
			
			deferred = $q.defer()
			
			@getCategoryBySlug(categorySlug).then (d) =>

				category = d.category
				types = (type._id for type in category.types)

				@getAllProducts().then (d2) =>

					products = d2.products
					categories = d2.categories

					products = _.filter products, (product) -> product.type._id in types
					deferred.resolve(products: products, category: category, categories: d2.categories)					
					
			deferred.promise

		getAllProducts: ->
			
			if @deferred?
				@deferred.promise
			else
				deferred = $q.defer()
				@deferred = deferred
				data = {}
				products = $resource("api/products").query =>

					# fetch types for all products
					jobs = 
						for product in products
							do (product) =>
								@getTypeById(product.type).then( (data) -> product.type = data.type )

					jobs.push @getCategories().then (data2) ->
						data.categories = data2.categories


					$q.all(jobs).then =>
						@products = products.splice(0)
						data.products = @products
						deferred.resolve(data)
				
			
				deferred.promise

		saveProduct: (product) ->
			deferred = $q.defer()
			
			if product._id?
				Products.update( { id: product._id }, product).$promise.then (product) => 
					return unless @products?
					old = _.findWhere @products, {'_id': product._id}
					@products = _.without @products, old
					@products.push product
					deferred.resolve(product)

			else
				Products.save( { }, product).$promise.then (product) => 
					@products?.push product
					@getTypeById(product.type).then (type) ->
						product.type = type
						deferred.resolve(product)

			deferred.promise

		removeProduct: (product) ->
			Products.remove({ id: product._id }, product).$promise.then => @products.splice @products.indexOf(product), 1

