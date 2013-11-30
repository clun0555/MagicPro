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

		showTypes: (categorySlug) ->
			@do [
				App.request "type:by:category", categorySlug
			], (types) =>
				@region.show new TypeNavigator collection: types 

		showProducts: (categorySlug, typeSlug) ->
			@do [
				App.request "product:by:type", typeSlug
			], (products) ->
				@region.show new ProductNavigatorView collection: products 


		showProduct:  (categorySlug, typeSlug, productSlug) ->
			@do [
				App.request "product:by:slug", productSlug
				App.request "cart:current"
			], (product, cart) ->
				@region.show new ProductDetailView model: product, cart: cart




