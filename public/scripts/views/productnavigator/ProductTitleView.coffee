define [
	"Base"
	"App"
	"templates/productnavigator/product_title"
], (Base, App, template) ->

	class ProductTitleView extends Base.ItemView
		template: template		
		className: 'product-title col-md-3'

		events:
			"click": "showProductDetail"

		showProductDetail: ->
			
			App.navigate "product:show:product", [  @model.get("type").get("category").get("slug"), @model.get("type").get("slug"), @model.get("slug") ]