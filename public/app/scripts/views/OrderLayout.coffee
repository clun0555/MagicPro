define [

	"Base"
	"App"
	"templates/orderLayout"
	"views/ProductNavigator"
	"views/categoryNavigator/CategoryNavigator"
	"views/typeNavigator/TypeNavigator"
	"views/orderHeader/OrderMenu"
	"models/MenuCollection"

], (Base, App, template, ProductNavigator, CategoryNavigator, TypeNavigator, OrderMenu, MenuCollection) ->

	class OrderLayout extends Base.Layout

		className: "order-layout container"
		template: template

		regions: menu: "#order-menu", content: "#order-content"

		menuStatus: new MenuCollection()

		events:
			"click .category-menu .category": "showCategory"
			"click .category-menu .type": "showType"
			"click .category-menu .product": "showProduct"

		initialize: ->
			@render

		onShow: ->
			@menu.show new OrderMenu( collection: @menuStatus )
			@content.show new CategoryNavigator()

		showCategory: ->
			@menuStatus.set({ id:"category", label: "Category"})
			@menuStatus.add({ id:"type", label: "Type"})
			@content.show new CategoryNavigator()

		showType: ->
			@menuStatus.set([@menuStatus.at(0), { id:"type", label: "Type"}])
			@menuStatus.add({ id:"product", label: "Product"})
			@content.show new TypeNavigator()

		showProduct: ->
			@content.show new ProductNavigator()

