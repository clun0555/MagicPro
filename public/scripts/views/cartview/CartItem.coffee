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
			categorySlug = @model.get("product").get("type").get("category").get("slug")
			typeSlug = @model.get("product").get("type").get("slug")
			productSlug = @model.get("product").get("slug")
			App.navigate "product:show:product", [ categorySlug, typeSlug, productSlug ]
