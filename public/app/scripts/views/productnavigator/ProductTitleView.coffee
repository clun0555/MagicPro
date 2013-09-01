define [
	"Base"
	"templates/productnavigator/product_title"
], (Base, template) ->

	class ProductTitleView extends Base.ItemView
		template: template		
		className: 'product-title col-md-3'
