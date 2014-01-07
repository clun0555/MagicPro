define [
	"underscore"
	"common/models/Composition-model"
], (_, Composition) ->

	class Bundle

		constructor: (options = {}) ->
			{ @product } = options
			@compositions = []

		updateComposition: (design, quantity) ->
			composition = @getOrCreateComposition(design)
					
			if quantity and quantity > 0
				composition.quantity = parseInt(quantity, 10)
				@compositions.push composition unless _.contains @compositions, composition
			else
				@removeComposition(composition)
				

		getOrCreateComposition: (design) ->
			@getComposition(design._id) ? new Composition(design: design)

		getComposition: (designId) ->
			_.find @compositions, (composition) -> composition.design._id is designId

		removeComposition: (composition) ->
			if _.contains @compositions, composition
				index = @compositions.indexOf(composition)
				@compositions.splice index, 1

		isEmpty: ->
			@compositions.length is 0

		# retrieves/calculate bundle quantity. If designId is specified will only return quantity for that design
		quantity: (designId) ->
			if designId?
				composition = @getComposition designId
				composition?.quantity ? 0
			else
				_.reduce(@compositions,  ((memo, model) -> memo + model.quantity), 0)

		pieces: (designId) ->
			if designId?
				composition = @getComposition designId
				composition?.pieces(@product) ? 0
			else
				_.reduce(@compositions,  ((memo, model) => memo + model.pieces(@product)), 0)

		# retrieves/calculate bundle price. If designId is specified will only return price for that design
		price: (designId) ->
			@quantity(designId) * @product.price * @product.inner

		toJSON: ->
			compositions: @compositions
			product: @product._id

		toObject: ->
			obj = 
				product: @product
				compositions: []

			for composition in @compositions
				obj.compositions.push composition.toObject()

			obj


		fromJSON: (json) ->			
			for jsonComposition in json.compositions
				@compositions.push new Composition().fromJSON(jsonComposition)

			this