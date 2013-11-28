define [
	"Base"
	"App"
	"views/categorynavigator/CategoryNavigator"
	"views/typenavigator/TypeNavigator"
	"views/productnavigator/ProductNavigatorView"
	"views/productdetail/ProductDetailView"
	"models/Cart"
], (Base, App, CategoryNavigator, TypeNavigator, ProductNavigatorView, ProductDetailView, Cart) ->

	class ProductController extends Base.Controller

		states: 
			"product:show:categories": "showCategories"
			"product:show:types": "showTypes"
			"product:show:products": "showProducts"
			"product:show:product": "showProduct"

		authorize: (action, args) -> @isLoggedIn()

		showCategories: (args, options) ->
			@do [
				App.request("category:all")
			], (categories) =>
				@region.show new CategoryNavigator collection: categories

		showTypes: (categoryIdentifier) ->
			@do [
				App.request "type:by:category", categoryIdentifier
			], (types) =>
				@region.show new TypeNavigator collection: types 

		showProducts: (categoryIdentifier, typeIdentifier) ->
			@do [
				App.request "product:by:type", typeIdentifier
			], (products) ->
				@region.show new ProductNavigatorView collection: products 


		showProduct:  (categoryIdentifier, typeIdentifier, productIdentifier) ->
			@do [
				App.request "product:by:identifier", productIdentifier
				App.request "cart:current"
			], (product, cart) ->
				@region.show new ProductDetailView model: product, cart: cart




