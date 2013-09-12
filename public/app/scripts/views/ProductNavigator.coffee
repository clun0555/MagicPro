define [

	"Base"
	"App"
	"views/productnavigator/ProductTitleView"

], (Base, App, ProductTitleView) ->
	
	class ProductNavigator extends Base.CollectionView
		
		itemView: ProductTitleView
		tagName: 'div'
		className: 'product-navigator thumnails container'

		initialize: ->
			@collection = App.request "products:all"
			@listenTo @collection, "reset", @render, this

