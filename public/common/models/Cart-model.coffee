define [
	"underscore"
	"common/models/Bundle-model"
], (_, Bundle) ->

	class Cart

		constructor: ->
			@bundles = []
			@lastItem = false
			@active = false
			@method = 'Delivery'

		getLastItem: () ->
			@lastItem
		updateBundle: ( product, design, quantity ) ->
			bundle = @getBundle product._id

			@lastItem = product

			unless bundle?
				isNew = true
				bundle = new Bundle( product: product )			

			bundle.updateComposition design, quantity

			if bundle.isEmpty()
				@active = "removed"
				@removeBundle bundle
			else if isNew
				@active = "added"
				@bundles.push bundle

		updateMethod: ( method ) ->
			@method = method

		updateNote: ( note ) ->
			@note = note

		getBundle: (productId) ->
			_.find @bundles, (bundle) -> bundle.product._id is productId

		removeBundle: (bundle) ->
			if _.contains @bundles, bundle
				index = @bundles.indexOf bundle
				@bundles.splice index, 1

		price: (product, designId) ->
			if product?
				bundle = @getBundle(product._id)
				return if bundle? then bundle.price(designId) else 0
			else
				_.reduce @bundles,   ((memo, bundle) -> memo + bundle.price()), 0

		quantity: (product, designId) ->
			if product?
				bundle = @getBundle(product._id)
				return 0 unless bundle?
				return if designId? then bundle.quantity(designId) else bundle.compositions[0].quantity				
			else
				_.reduce @bundles,   ((memo, bundle) -> memo + bundle.quantity()), 0

		pieces: (product, designId) ->
			if product?
				bundle = @getBundle(product._id)
				return if bundle? then bundle.pieces(designId) else 0
			else
				_.reduce @bundles,   ((memo, bundle) -> memo + bundle.pieces()), 0			


		isEmpty: ->
			@bundles.length == 0

		reset: ->
			@bundles = []
			@method = 'Delivery'
			@note = ''

		# check if cart has any un-existing designs for this product (may have been deleted)
		removeUnexistingCompositions: (product) ->
			bundle = @getBundle(product._id)
			bundle.removeUnexistingCompositions(product) if bundle?


		quantities: (product) ->
			quantities  = {}
			
			if (bundle = @getBundle(product._id))?
				for composition in bundle.compositions
					quantities[composition.design._id] = composition.quantity

			quantities

		compositions: ->
			compositions = []
			for bundle in @bundles
				for composition in bundle.compositions
					compositions.push composition

			compositions
			

		toJSON: ->
			bundles: @bundles
			method: @method
			note: @note

		toObject: ->
			obj = 
				bundles: []
				method: @method
				note: @note
				
			for bundle in @bundles
				obj.bundles.push bundle.toObject()

			obj


		fromJSON: (json) ->
			for jsonBundle in json.bundles ? []
				@bundles.push new Bundle(jsonBundle).fromJSON(jsonBundle)

			@method = json.method || 'Delivery'
			@note = json.note

			this

		clone: ->
			new Cart().fromJSON(@toObject())

		addTransectiontoGA: ->
			ga 'ecommerce:addTransaction',
				'id': '1234',
				'affiliation': 'MagicPro Online Order',
				'revenue': @price()
			_.map @compositions(), (composition) =>
				@addItemGA('1234', composition)
			ga 'ecommerce:send'

		addItemGA: (tranID, composition)->
			ga 'ecommerce:addItem',
				'id': tranID,
				'name': composition.product?.title,
				'sku': composition.product?.identifier,
				'category': composition.product.type?.title,
				'price': composition.product?.price,
				'quantity': composition.quantity
			ga 'ecommerce:send'