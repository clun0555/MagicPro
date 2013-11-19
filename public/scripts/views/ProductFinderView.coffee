define [

	"Base"
	"App"
	"views/productnavigator/ProductNavigatorView"
	"views/categorynavigator/CategoryNavigator"
	"views/typenavigator/TypeNavigator"
	"views/BreadCrumbView"
	"views/cartview/CartView"
	"templates/product_finder"

], (Base, App, ProductNavigator, CategoryNavigator, TypeNavigator, BreadCrumbView, CartView, template) ->

	class ProductFinderView extends Base.Layout

		className: "order-layout container"
		template: template

		regions: 
			breadcrumb: ".breadcrumb-region"
			content: ".navigator-region"	
			cart: ".cart-region"	

		events:
			"click .category-menu .category": "showCategory"
			"click .category-menu .type": "showType"
			"click .category-menu .product": "showProduct"

		initialize: ->
			@listenTo @model, "change", @showNavigator

			@listenTo App.state.cart, "all", console.log arguments

		onShow: ->
			@showBreadCrumb()
			@showNavigator()			
			@showCart()			

		showBreadCrumb: ->
			@breadcrumb.show new BreadCrumbView()

		showCart: ->
			@cart.show new CartView collection: App.state.cart

		showNavigator: ->
			@content.show @getNavigator()

		getNavigator: ->
			if @model.get("type")?				
				new ProductNavigator()
			else if @model.get("category")?
				new TypeNavigator()
			else
				new CategoryNavigator()


