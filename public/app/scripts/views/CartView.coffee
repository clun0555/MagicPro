define [

	"Base"
	"App"
	"templates/cart"

], (Base, App, template) ->

	class CartView extends Base.ItemView

		className: "cart-view container"
		template: template

		initialize: ->
			@render