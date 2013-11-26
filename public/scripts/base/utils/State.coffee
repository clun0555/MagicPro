define [
	"backbone"
], (Backbone) ->
	class State extends Backbone.Model

		initialize: ->
			super()

			@on "navigate", (state, args) =>
				@set "state", state
				@set "args", args 