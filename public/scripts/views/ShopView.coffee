define [

	"Base"
	"App"
	# "views/cartview/CartView"
	"templates/shop"

], (Base, App, template) ->

	class ShopView extends Base.Layout

		className: "product-finder container"
		
		template: template

		regions: 
			breadcrumbRegion: ".breadcrumb-region"
			contentRegion: ".content-region"
			cartRegion: ".cart-region"

		initialize: (options) ->
			{ @cart } = options

		# onRender: ->
		# 	@cartRegion.show new CartView model: @cart

		
		


