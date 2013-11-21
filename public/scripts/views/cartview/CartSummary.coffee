define [

	"Base"
	"App"
	"templates/cartview/cart_summary"

], (Base, App, template) ->

	class CartSummary extends Base.ItemView

		className: "cart-summary"
		template: template

		modelEvents: 
			"change": "render"	

