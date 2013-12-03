define [
	"Base"
	"App"
	"views/cartdetailview/CartDetailView"	
], (Base, App, CartDetailView) ->

	class CartController extends Base.Controller

		states: 
			"product:show:cart": "showCart"
			
		authorize: (action, args) -> @isLoggedIn()

		showCart: (args, options) ->
			@do [
				App.request "cart:current"
			], (cart) =>				
				@region.show new CartDetailView model: cart

		




