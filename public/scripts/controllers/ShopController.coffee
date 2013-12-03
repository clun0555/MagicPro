define [
	"Base"
	"App"
	"controllers/ProductController"
	"controllers/BreadCrumbController"
	"controllers/CartController"
	"views/cartview/CartView"
	"views/ShopView"
], (Base, App, ProductController, BreadCrumbController, CartController, CartView, ShopView) ->

	class ShopController extends Base.Controller

		states: 
			"product:show:categories": "showShop"
			"product:show:types": "showShop"
			"product:show:products": "showShop"
			"product:show:product": "showShop"
			"product:show:cart": "showShop"
				
		authorize: (action, args) -> @isLoggedIn()

		showShop: -> 
			@do [
				App.request("cart:current")
			], (cart) ->
			
				# do nothing if view is alredy rendered. Sub controllers will do their job
				return if @region.currentView instanceof ShopView
				
				shopView = new ShopView cart: cart
				
				# instanciate sub controllers
				@listenTo shopView, "render", =>
					@sub new ProductController region: shopView.contentRegion
					@sub new BreadCrumbController region: shopView.breadcrumbRegion
					@sub new CartController region: shopView.contentRegion

					# close controllers when view is closed
					@listenTo shopView, "close", @closeSubControllers

					@listenTo shopView.contentRegion, "show", ->
						# when view changes toggle cart
						showCart = App.state.get("state") in [
							"product:show:categories"
							"product:show:types"
							"product:show:products"
							"product:show:product"
						]

						if showCart
							shopView.cartRegion.show new CartView model: cart
						else
							shopView.cartRegion.close()

				@show shopView
			


				




