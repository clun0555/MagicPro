define [
	"./controllers"
	"resources/translations/translations"
], (controllers, translations) ->
	
	controllers
		.controller "LoginController", ($scope, $state, SessionService, $parse) ->
			
			$scope.login = ->
				$scope.errors = {}
				$scope.submited = true
				
				$scope.resetServerError = -> 
					$scope.serverError = false

				$scope.resetServerError()

				if $scope.credentials.$valid

					SessionService.login($scope.email, $scope.password).then(
						
						->
							$state.go "shop.categories"
						->
							$scope.serverError = true
													
					)
				
	



