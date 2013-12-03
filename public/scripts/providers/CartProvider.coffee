define [
	"underscore"
	"Base"
	"App"
	"jquery"
	"models/Cart"
], (_, Base, App, $, Cart) ->


	App.reqres.setHandler "cart:current", =>
		job = $.Deferred()
		@cart = new Cart() unless @cart?
		job.resolve @cart
		job

	App.reqres.setHandler "cart:save", (cb) =>
		@cart.save {}, success: ->
			@cart.clear()
			cb()
