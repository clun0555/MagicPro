define [
	"underscore"
	"Base"
	"models/Bundle"
], (_, Base, Bundle) ->
	
	class Cart extends Base.Model

		urlRoot: "/api/cart"

		initialize: ->
			@items = new Base.Collection()

		updateBundle: ( product, composition ) ->
			bundle = @getBundle product

			unless bundle?
				isNew = true
				bundle = new Bundle( product: product )				

			bundle.updateComposition composition

			if bundle.composition.isEmpty()
				@items.remove bundle 
			else if isNew 
				# add only when all is done. So that listeners have proper data	
				@items.add bundle 

			@set "price", @price()
			@set "quantity", @quantity()

			@trigger "updated"

		getBundle: (product) ->
			@items.findWhere "itemId": product.get("_id")

		quantity: (product, designId) ->
			if product? and designId? 
				bundle = @getBundle(product)
				return if bundle? then bundle.quantity(designId) else 0
			else
				@items.reduce  ((memo, bundle) -> memo + bundle.quantity()), 0

		price: (product, designId) ->
			if product? and designId? 
				bundle = @getBundle(product)
				return if bundle? then bundle.price(designId) else 0
			else
				@items.reduce  ((memo, bundle) -> memo + bundle.price()), 0









		

