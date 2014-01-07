define [
	"./services"
	"underscore"
	"common/models/Cart-model"
], (services, _, Cart) ->	
	
	services.service "CartService", ($resource, $q, SessionService, ShopService) ->
		
		Carts = $resource("api/carts/:_id")

		### Private ###

		getPopulatedLocalCartJSON = () ->
			deferred = $q.defer()

			localCartJSON = SessionService.retrieveLocal("cart")

			unless localCartJSON?
				deferred.resolve({})
				return deferred.promise

			productIds = (bundle.product for bundle in localCartJSON.bundles)

			products = ShopService.getProductsByIds(productIds).then (products) ->
				
				for bundle in localCartJSON.bundles
					bundle.product = _.findWhere products,  "_id": bundle.product
					for composition in bundle.compositions
						composition.design = _.findWhere bundle.product.designs, "_id": composition.design


				deferred.resolve localCartJSON

			deferred.promise

		cart = ->
			SessionService.get().cart


		### Public ###

		update: (product, design, quantity) ->
			
			cart().updateBundle product, design, quantity
			@store()

		get:  ->
			deferred = $q.defer()

			if cart()
				deferred.resolve cart()
				
			else 

				getPopulatedLocalCartJSON().then (jsonCart) ->
				
					SessionService.keep "cart", new Cart().fromJSON(jsonCart)				

					deferred.resolve cart()
				
				
			deferred.promise

		store: ->
			SessionService.storeLocal "cart", cart().toJSON()

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



		
			







