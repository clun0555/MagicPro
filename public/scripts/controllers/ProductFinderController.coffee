###

	TODO: Handle navigate properly. Should retrieve type/category by id. Populate App.state,  and show the proper views in the region. Breadcrumb, (Type/Category/Product)Navigator

###
define [
	"Base"
	"App"
	"views/ProductFinderView"
	"models/Cart"
], (Base, App, ProductFinderView, Cart) ->

	class ProductFinderController extends Base.Controller
		
		routes: 
			"products": "showNavigator"
			"products/:categoryIdentifier": "showNavigator"
			"products/:categoryIdentifier/:typeIdentifier": "showNavigator"
			"products/:categoryIdentifier/:typeIdentifier/:productIdentifier": "showNavigator"

		constructor: ->
			super
			App.state.productFinder = new Base.Model()
			App.state.cart = new Cart()

			@listenTo App.state.productFinder, "change", @changeTitle

		authorize: (action) -> 
			
			# navigate action is restricted to logged in users
			return @isLoggedIn() if action is "showNavigator" 				

			return true				


		changeTitle: ->
			state = App.state.productFinder
			
			title = 

				if state.get("product")?
					state.get("product").title
				else if state.get("type")?
					state.get("category").title + " > " + state.get("type").title
				else if state.get("category")?
					state.get("category").title
				else
					"Home" # TODO use translation

			@title title



		showNavigator: (categoryIdentifier, typeIdentifier, productIdentifier) ->
			
			$.when(
				App.request("categories:by:identifier", categoryIdentifier)
				App.request("types:by:identifier", typeIdentifier)
				App.request("products:by:identifier", productIdentifier)
			).done ( category, type, product ) =>
				App.state.productFinder.set "category": category?.toJSON(), "type": type?.toJSON(), "product": product?.toJSON() 				
				@show new ProductFinderView model: App.state.productFinder

		showHome: ->
			@run "showNavigator"

		# shortcut to navigate to a specific category. If categoryId is not defined, will navigate to current category
		showCategory: (categoryIdentifier) ->
			categoryIdentifier ?= App.state.productFinder.get("category").identifier
			@run "showNavigator", [ categoryIdentifier ]

		# shortcut to navigate to a specific type in the current category. If typeIdentifier is not defined, will navigate to current type
		showType: (typeIdentifier) ->
			typeIdentifier ?= App.state.productFinder.get("type").identifier
			categoryIdentifier = App.state.productFinder.get("category").identifier
			@run "showNavigator", [ categoryIdentifier, typeIdentifier ]

		showProduct: (productIdentifier) ->
			typeIdentifier = App.state.productFinder.get("type").identifier
			categoryIdentifier = App.state.productFinder.get("category").identifier
			@run "showNavigator", [ categoryIdentifier, typeIdentifier, productIdentifier ]

		
				
					
