define [

	"Base"
	"App"
	"views/ProductNavigatorView"
	"views/categoryNavigator/CategoryNavigator"
	"views/typeNavigator/TypeNavigator"
	"views/BreadCrumbView"
	"templates/product_finder"

], (Base, App, ProductNavigator, CategoryNavigator, TypeNavigator, BreadCrumbView, template) ->

	class ProductFinderView extends Base.Layout

		className: "order-layout container"
		template: template

		regions: 
			menu: "#order-menu", 
			breadcrumb: ".breadcrumb-region", 
			content: "#order-content"		

		events:
			"click .category-menu .category": "showCategory"
			"click .category-menu .type": "showType"
			"click .category-menu .product": "showProduct"

		initialize: ->
			@listenTo @model, "change", @showCurrentView


		onShow: ->
			@showBreadCrumb()
			@showCurrentView()			

		showBreadCrumb: ->
			@breadcrumb.show new BreadCrumbView()

		showCurrentView: ->
			@content.show @getCurrentView()

		getCurrentView: ->
			if @model.get("type")?
				new ProductNavigator()
			else if @model.get("category")?
				new TypeNavigator()
			else
				new CategoryNavigator()


