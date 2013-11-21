define [

	"Base"
	"App"
	"views/productnavigator/ProductNavigatorView"
	"views/categorynavigator/CategoryNavigator"
	"views/typenavigator/TypeNavigator"
	"views/BreadCrumbView"
	"views/cartview/CartView"
	"views/productdetail/ProductDetailView"
	"templates/product_finder"

], (Base, App, ProductNavigator, CategoryNavigator, TypeNavigator, BreadCrumbView, CartView, ProductDetailView, template) ->

	class ProductFinderView extends Base.Layout

		className: "product-finder container"
		template: template

		regions: 
			breadcrumb: ".breadcrumb-region"
			content: ".content-region"
			cart: ".cart-region"	

		events:
			"click .category-menu .category": "showCategory"
			"click .category-menu .type": "showType"
			"click .category-menu .product": "showProduct"

		initialize: ->
			@listenTo @model, "change", @showNavigator			

		onShow: ->
			@showBreadCrumb()
			@showNavigator()			
			@showCart()			

		showBreadCrumb: ->
			@breadcrumb.show new BreadCrumbView(model: @model)

		showCart: ->
			@cart.show new CartView model: App.state.cart

		showNavigator: ->
			@content.show @getNavigator()

		getNavigator: ->
			if @model.get("product")?
				# TODO refactor to not have to re-create model from json
				new ProductDetailView model: new Base.Model(@model.get("product"))
			else if @model.get("type")?				
				new ProductNavigator()
			else if @model.get("category")?
				new TypeNavigator()
			else
				new CategoryNavigator()


