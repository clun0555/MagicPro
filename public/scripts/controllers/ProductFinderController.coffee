###

	TODO: Handle navigate properly. Should retrieve type/category by id. Populate App.state,  and show the proper views in the region. Breadcrumb, (Type/Category/Product)Navigator

###
define [
	"Base"
	"App"
	"views/ProductFinderView"
], (Base, App, ProductFinderView) ->

	class ProductFinderController extends Base.Controller
		
		routes: 
			"products": "showNavigator"
			"products/:categoryId": "showNavigator"
			"products/:categoryId/:typeId": "showNavigator"

		constructor: ->
			super
			App.state.productFinder = new Base.Model()
			App.state.cart = new Base.Collection()

		authorize: (action) -> 
			
			# navigate action is restricted to logged in users
			return @isLoggedIn() if action is "showNavigator" 				

			return true				

		showNavigator: (categoryId, typeId) ->
			
			$.when(
				App.request("categories:byid", categoryId)
				App.request("types:byid", typeId)
			).done ( category, type ) =>
				App.state.productFinder.set "category": category?.toJSON(), "type": type?.toJSON()								
				@show new ProductFinderView model: App.state.productFinder

		navigateHome: ->
			@run "showNavigator"

		# shortcut to navigate to a specific category. If categoryId is not defined, will navigate to current category
		navigateCategory: (categoryId) ->
			@run "showNavigator", [ categoryId ? App.state.productFinder.get("category")._id ]

		# shortcut to navigate cat, type
		navigateType: (typeId) ->
			categoryId = App.state.productFinder.get("category")._id
			@run "showNavigator", [ categoryId, typeId ]
				
					
