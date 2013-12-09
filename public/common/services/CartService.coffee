define [
	"./services"
	"underscore"
	"common/models/Cart"
], (services, _, Cart) ->	
	
	services.service "CartService", ($resource, $q) ->
		
		Carts = $resource("api/carts/:_id")

		cart = new Cart()			

		update: (product, design, quantity) ->
			cart.updateBundle product, design, quantity

		quantities: (product) ->
			quantities  = {}
			
			if (bundle = cart.getBundle(product._id))?
				for composition in bundle.compositions
					quantities[composition.design._id] = composition.quantity

			quantities

		get: ->
			cart 

		save: ->
			deferred = $q.defer()
			
			# TODO find a better way to do that.. prevents circular references
			jsonCart = JSON.parse(JSON.stringify(cart))
			
			# new Carts(jsonCart).$save jsonCart, ->

			Carts.save {}, jsonCart, ->
				cart.reset()
				deferred.resolve()

			deferred.promise()

			







