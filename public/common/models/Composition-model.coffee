define [
	"underscore"
], (_) ->

	class Composition
		
		constructor: (options = {}) ->
			{ @design, @product }	= options

		pieces: (product) ->
			@quantity * ( product.inner ? 1 )
			

		toJSON: ->
			quantity: @quantity
			design: @design._id	

		toObject: ->
			quantity: @quantity
			design: @design			
			product: @product			

		fromJSON: (json) ->
			@quantity = json.quantity
			@design = json.design
			@product = json.product

			this