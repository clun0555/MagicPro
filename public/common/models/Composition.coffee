define [
	"underscore"
], (_) ->

	class Composition
		
		constructor: (options = {}) ->
			{ @design }	= options

		pieces: (product) ->
			@quantity * ( product.inner ? 1 )
			

		toJSON: ->
			quantity: @quantity
			design: @design._id	

		fromJSON: (json) ->
			@quantity = json.quantity
			@design = json.design

			this