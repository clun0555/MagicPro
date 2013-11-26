define [

	"Base"
	"App"
	"views/productnavigator/ProductTitleView"

], (Base, App, ProductTitleView) ->
	
	class ProductNavigatorView extends Base.CollectionView
		
		itemView: ProductTitleView
		tagName: 'div'
		className: 'product-navigator thumnails'

