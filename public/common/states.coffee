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

			$stateProvider

				.state "index", 
					url: "/"
					template: '<ui-view/>'
					controller: ($state, SessionService) ->

						homeState = 
							if not SessionService.isAuthentificated()
								"login"
							else if SessionService.user()?.status is "validated"
								"shop.categories"
							else
								"validating"

						$state.go homeState			

						

				.state "error",
					url: "/error/:code"
					templateUrl: "common/views/error.html" 
					controller: ($scope, $stateParams) ->
						$scope.code = $stateParams.code

				.state "login",
					url: "/login"
					templateUrl: "common/views/login.html" 
					controller: "LoginController" 

				.state "forgot",
					url: "/forgot?email"
					templateUrl: "common/views/forgot.html" 
					controller: "ForgotController" 

				.state "reset",
					url: "/reset/:forgotKey"
					templateUrl: "common/views/reset.html" 
					controller: "ResetController"
					resolve: 
						user: (UserService, $stateParams) ->
							UserService.findByForgotKey $stateParams.forgotKey

				.state "register",
					url: "/register?email"
					templateUrl: "common/views/register.html" 
					controller: "RegisterController" 

				.state "validating",
					url: "/validating"
					templateUrl: "common/views/validating.html"

				.state "account",
					templateUrl: "common/views/account.html"
					resolve:
						user: (SessionService) -> SessionService.user()

				.state "account.profile",
					url: "/profile"
					templateUrl: "common/views/profile.html"
					controller: "ProfileController"
				
				.state "account.password",
					url: "/profile/password"
					templateUrl: "common/views/change_password.html"
					controller: "PasswordChangeController"
					

				.state "otherwise",
					url: "*path"
					controller: ($scope, $stateParams, $state) ->
						$state.go "error", {code: 404}, { location: false }
						
					
						
						







				

