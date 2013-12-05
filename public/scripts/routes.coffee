###
Defines the main routes in the application.
The routes you see here will be anchors '#/' unless specifically configured otherwise.
###
define [
	"app"
], (app) ->
	
	app.config ($stateProvider, $urlRouterProvider) ->

		breadcrumb = 			
			templateUrl: "views/breadcrumb.html"
			controller: "BreadCrumbController"

		cart = 			
			templateUrl: "views/cart.html"
			controller: "CartController"

		$urlRouterProvider.otherwise("/products")

		$stateProvider
			.state "shop", 
				abstract: true
				templateUrl: "views/shop.html"
				
			.state "shop.categories",
				url: "/products"
				resolve: 
					data: ($stateParams, ShopService) ->
						ShopService.getCategories()

					alan: () ->
						"Hello Alan"	
				views: 
					"breadcrumb": breadcrumb
					"cart": cart					
					"navigator":
						templateUrl: "views/categories.html"
						controller: "ShopCategoriesController"
						


			.state "shop.types",
				url: "/products/:category"
				resolve: 
					data: ($stateParams, ShopService) ->
						ShopService.getCategoryBySlug($stateParams.category)
				views: 
					"breadcrumb": breadcrumb
					"cart": cart
					"navigator":
						templateUrl: "views/types.html"
						controller: "ShopTypesController"
						


			.state "shop.products",
				url: "/products/:category/:type"
				resolve: 
					data: ($stateParams, ShopService) ->
						ShopService.getProductsByCategoryTypeSlug($stateParams.category, $stateParams.type)
				views: 
					"breadcrumb": breadcrumb
					"cart": cart
					"navigator":
						templateUrl: "views/products.html"
						controller: "ShopProductsController"



			.state "shop.product",
				url: "/products/:category/:type/:product"
				resolve: 
					data: ($stateParams, ShopService) ->
						ShopService.getProductBySlug($stateParams.category, $stateParams.type, $stateParams.product)
				views: 
					"breadcrumb": breadcrumb
					"cart": cart
					"navigator":
						templateUrl: "views/product.html"
						controller: "ShopProductController"

			.state "cart",
				url: "/cart"
				templateUrl: "views/cart_preview.html" 
				controller: "CartPreviewController"




				

