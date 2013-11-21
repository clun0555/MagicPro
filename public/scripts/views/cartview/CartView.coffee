define [

	"Base"
	"App"
	"views/cartview/CartSummary"
	"views/cartview/CartItems"
	"templates/cartview/cart"

], (Base, App, CartSummary, CartItems, template) ->

	class CartView extends Base.Layout

		className: "cart-view container"
		template: template	
		regions: 
			"summary": ".summary-region"
			"items": ".items-region"

		onShow: ->
			@summary.show new CartSummary model: @model
			@items.show new CartItems collection: @model.items