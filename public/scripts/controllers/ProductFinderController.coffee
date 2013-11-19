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
			"products": "navigate"
			"products/:categoryId": "navigate"
			"products/:categoryId/:typeId": "navigate"

		constructor: ->
			super
			App.state.productFinder = new Base.Model()
			App.state.cart = new Base.Collection()

		authorize: (action) -> 
			
			# navigate action is restricted to logged in users
			return @isLoggedIn() if action is "navigate" 				

			return true
				

		navigate: (categoryPath, typePath) ->
			@show new ProductFinderView model: App.state.productFinder