###
Defines the main routes in the application.
The routes you see here will be anchors '#/' unless specifically configured otherwise.
###
define [
	"app"
], (app) ->
	
	app
		.config ( $stateProvider, $urlRouterProvider) ->	

			# root state
			$urlRouterProvider.when "", "/products"

			$stateProvider

				.state "error",
					url: "/error/:code"
					templateUrl: "common/views/error.html" 
					controller: ($scope, $stateParams) ->
						$scope.code = $stateParams.code

				.state "login",
					url: "/login"
					templateUrl: "common/views/login.html" 
					controller: "LoginController" 

				.state "admin",
					url: "/admin"
					data: security: "admin"
					templateUrl: "common/views/admin.html"


				.state "otherwise",
					url: "*path"
					controller: ($scope, $stateParams, $state) ->
						$state.go "error", {code: 404}, { location: false }
						
					
						
						







				

