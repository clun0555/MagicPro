define [
	"./services"
	"underscore"
	"common/models/Cart-model"
], (services, _, Cart) ->	
	
	services

		# .config (AuthentificationServiceProvider) ->
		# 	# AuthentificationServiceProvider.setName "rom"
		# 	AuthentificationServiceProvider.addLoginInitializer ->
		# 		alert "logged in"

		.service "CartService", ($resource, $q, SessionService, ShopService, $rootScope, AuthentificationService) ->
			
			Carts = $resource("api/carts/:_id")

			$rootScope.$watch "user", -> 
				@deferred = null

			### Private ###

			getPopulatedLocalCartJSON = () ->
				deferred = $q.defer()

				localCartJSON = SessionService.retrieveLocal("cart")
				populatedCart = { bundles: [] }

				unless localCartJSON?
					deferred.resolve({})
					return deferred.promise

				productIds = (bundle.product for bundle in localCartJSON.bundles)

				products = ShopService.getProductsByIds(productIds).then (products) ->
					
					for bundle in localCartJSON.bundles

						product = _.findWhere products,  "_id": bundle.product
						
						if product? 
							populatedBundle = _.clone bundle
							
							populatedBundle.product = product
							populatedBundle.compositions = []	
							
							for composition in bundle.compositions
								design = _.findWhere product.designs, "_id": composition.design
								if design?
									populatedComposition = _.clone composition
									populatedComposition.design = design
									populatedComposition.product = product
									populatedBundle.compositions.push populatedComposition

							if populatedBundle.compositions.length
								populatedCart.bundles.push populatedBundle


					deferred.resolve populatedCart

				deferred.promise

			cart = ->
				SessionService.get()?.cart

			### Public ###
			class API

				constructor: ->
					AuthentificationService.addLoginInitializer =>
						@deferred = null
						@get()

				update: (product, design, quantity) ->
					
					cart().updateBundle product, design, quantity
					@store()

				get:  ->
					return @deferred.promise if @deferred?
					
					@deferred = $q.defer()

					if cart()
						@deferred.resolve cart()
						
					else 

						getPopulatedLocalCartJSON().then (jsonCart) =>
						
							SessionService.keep "cart", new Cart().fromJSON(jsonCart)

							@deferred.resolve cart()
						
						
					@deferred.promise

				store: ->
					SessionService.storeLocal "cart", cart().toJSON()

				removeUnexistingCompositions: (product) ->
					cart().removeUnexistingCompositions(product)
					@store()

				save: ->
					deferred = $q.defer()
					
					# TODO find a better way to do that.. prevents circular references
					jsonCart = JSON.parse(JSON.stringify(cart()))
					
					# new Carts(jsonCart).$save jsonCart, ->

					Carts.save {}, jsonCart, =>
						cart().reset()
						@store()
						deferred.resolve()

					deferred.promise



			new API()


