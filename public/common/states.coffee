
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
					# views: 
						# "cart-drawer@": 
						# 	templateUrl: "app/shop/views/cart.html" 
						# 	controller: "CartController"							


						# "left-drawer@": 
						# 	templateUrl: "app/shop/views/left_drawer.html"
						# 	controller: "ShopSideCategoriesController"							

						# "":
						# 	template: "<div ui-view autoscroll='false' class='main-region-inner'></div>"
						

				.state "index",
					url: ""
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
					url: "/error/:code"
					views: "@":
						templateUrl: "common/views/error.html" 
						controller: ($scope, $stateParams) ->
							$scope.code = $stateParams.code

				.state "login",
					url: "/login"
					views: "@":
						templateUrl: "common/views/login.html" 
						controller: "LoginController" 

				.state "forgot",	
					url: "/forgot?email"
					views: "@":
						templateUrl: "common/views/forgot.html" 
						controller: "ForgotController" 

				.state "reset",
					url: "/reset/:forgotKey"
					views: "@":
						templateUrl: "common/views/reset.html" 
						controller: "ResetController"
						resolve: 
							user: (UserService, $stateParams) ->
								UserService.findByForgotKey $stateParams.forgotKey

				.state "register",
					url: "/register?email"
					views: "@":
						templateUrl: "common/views/register.html" 
						controller: "RegisterController" 

				.state "validating",
					url: "/validating"
					views: "@":
						templateUrl: "common/views/validating.html"

				.state "account",
					views: "@":
						templateUrl: "common/views/account.html"
						resolve:
							user: (SessionService) -> SessionService.user()

				.state "account.profile",
					parent: "account"
					url: "/profile"				
					templateUrl: "common/views/profile.html"
					controller: "ProfileController"
					resolve:
						user: (SessionService) -> SessionService.user()

				
				.state "account.password",
					parent: "account"
					url: "/profile/password"
					templateUrl: "common/views/change_password.html"
					controller: "PasswordChangeController"
					resolve:
						user: (SessionService) -> SessionService.user()
					

				.state "otherwise",
					url: "*path"
					views: "@":
						controller: ($scope, $stateParams, $state) ->
							$state.go "error", {code: 404}, { location: false }
						
					
						
						







				

