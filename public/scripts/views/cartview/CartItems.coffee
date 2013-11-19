define [

	"Base"
	"App"
	"views/cartview/CartItem"	

], (Base, App, CartItem) ->

	class CartItems extends Base.CollectionView

		className: "cart-items"
		itemView: CartItem
		tagName: "ul"