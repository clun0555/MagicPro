define [

	"Base"
	"App"
	"templates/cartview/cart_item"

], (Base, App, template) ->

	class CartItem extends Base.ItemView

		className: "cart-item"
		template: template	
		tagName: "li"	

		modelEvents: 
			"change": "render"

		events: 
			"click": "openProduct"


		openProduct: ->
			App.execute "product:finder:controller", "show:product", [ @model.get("productIdentifier") ]
