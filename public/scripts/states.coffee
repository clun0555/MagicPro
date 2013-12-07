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
					data: security: "loggedIn"
									
				.state "shop.categories",
					url: "/products"
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
					controller: "LoginController" 

				.state "admin",
					url: "/admin"
					data: security: "admin"
					templateUrl: "views/admin.html" 


	# TODO Move this somewhere else
	app.run ($rootScope, $state, $injector, SessionService) ->


		# Enforce security when state changes
		$rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
			
			if toState.data.security?
				# if state has security parameters

				if SessionService.get()?
					# if there is an active session	
					
					unless SessionService.security(toState.data.security)
						# if session doesn't meet security, redirect to error page
						event.preventDefault()
						$state.go "error", {code: 402}, {location: "false"}

				else
					# no active session yet, ask server				
					event.preventDefault()
					SessionService.fetchSession().then(
						->
							# server has an active session. It is now stored on the client
							# replay state to check security
							$state.transitionTo toState							
						->	
							# server has no active session. Ask user to login					
							$state.transitionTo "login"
					)
			
		# Hanlle state change errors. ex: Resolver got rejected.  		
		$rootScope.$on "$stateChangeError", (event, toState, toParams, fromState, fromParams, error) ->
			
			code = error?.code ? 500 
			
			if code is 403
				$state.go "login"
			else
				$state.go "error", {code: code}, {location: "false"}




				

