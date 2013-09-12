define [

	"Base"
	"App"
	"templates/orderLayout"
	"views/ProductNavigator"
	"views/categoryNavigator/CategoryNavigator"
	"views/typeNavigator/TypeNavigator"
	"views/OrderMenu"

], (Base, App, template, ProductNavigator, CategoryNavigator, TypeNavigator, OrderMenu) ->

	class OrderLayout extends Base.Layout

		className: "order-layout container"
		template: template

		regions: menu: "#order-menu", content: "#order-content"

		events:
			"click .category-menu": "showCategory"
			"click .type-menu": "showType"
			"click .product-menu": "showProduct"

		initialize: ->
			@render

		onRender: ->
			@menu.show new OrderMenu()
			@content.show new ProductNavigator()

		showCategory: ->
			@content.show new CategoryNavigator()

		showType: ->
			@content.show new TypeNavigator()

		showProduct: ->
			@content.show new ProductNavigator()

