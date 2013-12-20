define [
	"./controllers"
	"resources/translations/translations"
], (controllers, translations) ->
	
	controllers
		.controller "ForgotController", ($scope, $state, $stateParams, UserService, $parse) ->
			
			$scope.email = $stateParams.email

			$scope.forgot = ->
				$scope.errors = {}
				$scope.submited = true
				
				$scope.resetServerError = -> 
					$scope.serverError = false

				$scope.resetServerError()

				if $scope.credentials.$valid

					UserService.generateForgotKey($scope.email).then(
						
						->
							$scope.done = true
						->
							$scope.serverError = true
													
					)
				
	



