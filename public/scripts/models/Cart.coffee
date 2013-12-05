define [
	"underscore"
	"models/Bundle"
], (_, Bundle) ->

	class Cart 

		constructor: ->
			@bundles = []

		updateBundle: ( product, design, quantity ) ->
			bundle = @getBundle product._id

			unless bundle?
				isNew = true
				bundle = new Bundle( product: product )			

			bundle.updateComposition design, quantity

			if bundle.isEmpty() 
				@removeBundle bundle					
			else if isNew 
				@bundles.push bundle
			

		getBundle: (productId) ->
			_.find @bundles, (bundle) -> bundle.product._id is productId

		removeBundle: (bundle) ->
			if (index = @bundles.indexOf(bundle))
				@bundles.splice index, 1

		price: (product, designId) ->
			if product? and designId? 
				bundle = @getBundle(product.id)
				return if bundle? then bundle.price(designId) else 0
			else
				_.reduce @bundles,   ((memo, bundle) -> memo + bundle.price()), 0

		quantity: (product, designId) ->
			if product? and designId? 
				bundle = @getBundle(product.id)
				return if bundle? then bundle.quantity(designId) else 0
			else
				_.reduce @bundles,   ((memo, bundle) -> memo + bundle.quantity()), 0


		isEmpty: ->
			@bundles.lenght == 0

		reset: ->
			@bundles = []


		toJSON: ->
			bundles: @bundles
