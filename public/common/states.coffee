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
			# $urlRouterProvider.when "", "/products"

			$stateProvider

				.state "index", 
					url: ""
					template: '<ui-view/>'
					controller: ($state, SessionService) ->
						user = SessionService.user()

						if not SessionService.isSessionFetched()
							$state.go "login"
						else if user.role? and user.role in ["admin", "buyer"]
							$state.go "shop.categories"
						else
							$state.transitionTo "validating"							

						

				.state "error",
					url: "/error/:code"
					templateUrl: "common/views/error.html" 
					controller: ($scope, $stateParams) ->
						$scope.code = $stateParams.code

				.state "login",
					url: "/login"
					templateUrl: "common/views/login.html" 
					controller: "LoginController" 

				.state "validating",
					url: "/validating"
					templateUrl: "common/views/validating.html" 								

				.state "otherwise",
					url: "*path"
					controller: ($scope, $stateParams, $state) ->
						$state.go "error", {code: 404}, { location: false }
						
					
						
						







				

