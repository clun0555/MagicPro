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
					$scope.submiting = true

					UserService.generateForgotKey($scope.email).then(
						
						->
							$scope.submiting = false
							$scope.done = true
						->
							$scope.submiting = false
							$scope.serverError = true
													
					)
				
	



