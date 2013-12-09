define [
	"underscore"
	"common/models/Composition"
], (_, Composition) ->

	class Bundle

		constructor: (options) ->
			{ @product } = options
			@compositions = []

		updateComposition: (design, quantity) ->
			composition = @getOrCreateComposition(design)
					
			if quantity
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

		# retrieves/calculate bundle price. If designId is specified will only return price for that design
		price: (designId) ->
			@quantity(designId) * @product.price

		toJSON: ->
			compositions: @compositions
			product: @product._id