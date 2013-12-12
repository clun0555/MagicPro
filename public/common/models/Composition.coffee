define [
	"underscore"
], (_) ->

	class Composition
		
		constructor: (options = {}) ->
			{ @design }	= options
			

		toJSON: ->
			quantity: @quantity
			design: @design._id	

		fromJSON: (json) ->
			@quantity = json.quantity
			@design = json.design

			this