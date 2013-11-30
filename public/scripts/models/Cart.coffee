define [
	"underscore"
	"Base"
	"models/Bundle"
], (_, Base, Bundle) ->
	
	class Cart extends Base.Model

		urlRoot: "/api/carts"

		relations: [
			type: "HasMany"
			key: 'bundles'
			relatedModel: 'Bundle'
			includeInJSON: true
			collectionType: "BaseCollection"			
		]

		updateBundle: ( product, composition ) ->
			bundle = @getBundle product.id

			unless bundle?
				isNew = true
				bundle = new Bundle( product: product )			

			bundle.updateComposition composition

			if bundle.get("compositions").isEmpty()
				@get("bundles").remove bundle 
			else if isNew 
				# add only when all is done. So that listeners have proper data	
				@get("bundles").add bundle

			@set "price", @price()
			@set "quantity", @quantity()

			@trigger "updated"

		getBundle: (productId) ->
			@get("bundles").find (bundle) -> bundle.get("product").id is productId

		quantity: (product, designId) ->
			if product? and designId? 
				bundle = @getBundle(product.id)
				return if bundle? then bundle.quantity(designId) else 0
			else
				@get("bundles").reduce  ((memo, bundle) -> memo + bundle.quantity()), 0

		price: (product, designId) ->
			if product? and designId? 
				bundle = @getBundle(product.id)
				return if bundle? then bundle.price(designId) else 0
			else
				@get("bundles").reduce  ((memo, bundle) -> memo + bundle.price()), 0









		

