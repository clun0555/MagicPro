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