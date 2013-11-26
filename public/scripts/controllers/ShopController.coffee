define [
	"Base"
	"App"
	"controllers/ProductController"
	"controllers/BreadCrumbController"
	"views/ShopView"
], (Base, App, ProductController, BreadCrumbController, ShopView) ->

	class ShopController extends Base.Controller

		states: 
			"product:show:categories": "showShop"
			"product:show:types": "showShop"
			"product:show:products": "showShop"
			"product:show:product": "showShop"
				
		authorize: (action, args) -> @isLoggedIn()

		showShop: -> 
			@do [
				App.request("cart:current")
			], (cart) ->
			
				# do nothing if view is alredy rendered. Sub controllers will do their job
				return if @region.currentView instanceof ShopView
				
				shopView = new ShopView cart: cart
				
				@listenTo shopView, "render", =>
					@sub new ProductController region: shopView.contentRegion
					@sub new BreadCrumbController region: shopView.breadcrumbRegion

				@listenTo shopView, "close", @closeSubControllers

				@show shopView
			


				




