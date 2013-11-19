define [
	"Base"
	"App"
	"templates/productnavigator/product_title"
], (Base, App, template) ->

	class ProductTitleView extends Base.ItemView
		template: template		
		className: 'product-title col-md-3'


		events:
			"click .buy-button": "addToCart"

		addToCart:  ->
			App.state.cart.add @model

