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
			
			App.navigate "product:show:product", [  @model.get("categoryIdentifier"), @model.get("typeIdentifier"), @model.id ]