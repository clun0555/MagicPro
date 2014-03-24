###
Defines the main routes in the application.
The routes you see here will be anchors '#/' unless specifically configured otherwise.
###
define [
	"app"
], (app) ->
	
	app
		.config ( $stateProvider, $urlRouterProvider, $locationProvider) ->	

			$locationProvider.html5Mode true
			# This append a ! to the URL to be enable to recognised by the google crawler
			$locationProvider.hashPrefix('!')

			$urlRouterProvider.when "/",  ($match, $stateParams, SessionService, $state) ->
				# alert "controller2"
				homeState = "home"
					# if not SessionService.isAuthentificated()
					# 	"login"
					# else if SessionService.user()?.status is "validated"
						
					

				$state.go homeState	

			$stateProvider

				.state "layout",
					url: ""
					abstract: true
					views: 
						"cart-drawer@": 
							templateUrl: "app/shop/views/cart.html" 
							controller: "CartController"							


						"left-drawer@": 
							templateUrl: "app/shop/views/left_drawer.html"
							controller: "ShopSideCategoriesController"
							resolve: 
								data: ($stateParams, ShopService) ->
									ShopService.getCategories()

						"":
							template: "<div ui-view autoscroll='false'></div>"
						

				.state "index",
					url: ""
					parent: "layout"
					onEnter: ($state, SessionService) ->
						homeState = 
							if not SessionService.isAuthentificated()
								"login"
							else if SessionService.user()?.status is "validated"
								"home"
							else
								"validating"

						$state.go homeState	
						
					# views: 
						
					# 	"@":
					# 		template: "<ui-view />"
							
							# controller: ($state, SessionService) ->
							# 	homeState = 
							# 		if not SessionService.isAuthentificated()
							# 			"login"
							# 		else if SessionService.user()?.status is "validated"
							# 			"shop.products"
							# 		else
							# 			"validating"

							# 	$state.go homeState	


										
						

				.state "error",
					parent: "layout"
					url: "/error/:code"
					templateUrl: "common/views/error.html" 
					controller: ($scope, $stateParams) ->
						$scope.code = $stateParams.code

				.state "login",
					parent: "layout"
					url: "/login"
					templateUrl: "common/views/login.html" 
					controller: "LoginController" 

				.state "forgot",	
					parent: "layout"
					url: "/forgot?email"
					templateUrl: "common/views/forgot.html" 
					controller: "ForgotController" 

				.state "reset",
					parent: "layout"
					url: "/reset/:forgotKey"
					templateUrl: "common/views/reset.html" 
					controller: "ResetController"
					resolve: 
						user: (UserService, $stateParams) ->
							UserService.findByForgotKey $stateParams.forgotKey

				.state "register",
					parent: "layout"
					url: "/register?email"
					templateUrl: "common/views/register.html" 
					controller: "RegisterController" 

				.state "validating",
					parent: "layout"
					url: "/validating"
					templateUrl: "common/views/validating.html"

				.state "account",
					parent: "layout"
					templateUrl: "common/views/account.html"
					resolve:
						user: (SessionService) -> SessionService.user()

				.state "account.profile",
					parent: "account"
					url: "/profile"
					templateUrl: "common/views/profile.html"
					controller: "ProfileController"
				
				.state "account.password",
					parent: "account"
					url: "/profile/password"
					templateUrl: "common/views/change_password.html"
					controller: "PasswordChangeController"
					

				.state "otherwise",
					url: "*path"
					controller: ($scope, $stateParams, $state) ->
						$state.go "error", {code: 404}, { location: false }
						
					
						
						







				

