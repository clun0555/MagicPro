###
Defines the main routes in the application.
The routes you see here will be anchors '#/' unless specifically configured otherwise.
###
define [
	"app"
], (app) ->
	
	app
		.config ( $stateProvider, $urlRouterProvider) ->

			
			$urlRouterProvider.otherwise("/products")

			$stateProvider
				.state "shop", 
					abstract: true
					templateUrl: "views/shop.html"
					url: '/products'
				
									
				.state "shop.categories",
					url: ""
					templateUrl: "views/categories.html"
					controller: "ShopCategoriesController"
					resolve: 
						data: ($stateParams, ShopService) ->
							ShopService.getCategories()

				.state "shop.categories.types",
					url: "/:category"					
					resolve: 
						data: ($stateParams, ShopService) ->
							ShopService.getCategoryBySlug($stateParams.category)
					views:
						"@shop":
							templateUrl: "views/types.html"
							controller: "ShopTypesController"
					

				.state "shop.products",
					url: "/products/:category/:type"
					resolve: 
						data: ($stateParams, ShopService) ->
							ShopService.getProductsByCategoryTypeSlug($stateParams.category, $stateParams.type)

					templateUrl: "views/products.html"
					controller: "ShopProductsController"


				.state "shop.product",
					url: "/products/:category/:type/:product"
					resolve: 
						data: ($stateParams, ShopService) ->
							ShopService.getProductBySlug($stateParams.category, $stateParams.type, $stateParams.product)
					
					templateUrl: "views/product.html"
					controller: "ShopProductController"

				.state "cart",
					url: "/cart"
					templateUrl: "views/cart_preview.html" 
					controller: "CartPreviewController"

				.state "error",
					url: "/error/:code"
					templateUrl: "views/error.html" 
					controller: ($scope, $stateParams) ->
						$scope.code = $stateParams.code

				.state "login",
					url: "/login"
					templateUrl: "views/login.html" 


	app.run ($rootScope, $state) ->

		$rootScope.$on "$stateChangeError", (event, toState, toParams, fromState, fromParams, error) ->
			
			code = error?.code ? 500 
			
			if code is 403
				$state.go "login"
			else
				$state.go "error", {code: code}, {location: "replace"}




				

