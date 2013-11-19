define [

	"Base"
	"App"
	"templates/cartview/cart_item"

], (Base, App, template) ->

	class CartItem extends Base.ItemView

		className: "cart-item"
		template: template	
		tagName: "li"	