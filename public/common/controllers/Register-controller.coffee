define [
	"./controllers"	
], (controllers) ->
	
	controllers
		.controller "RegisterController", ($scope, $state, SessionService, $stateParams, $parse) ->
			
			$scope.user = 
				email: $stateParams.email

			$scope.register = ->
				$scope.errors = {}
				$scope.submited = true
				
				$scope.resetServerError = -> 
					$scope.serverError = false

				$scope.resetServerError()

				if $scope.credentials.$valid
					$scope.submiting = true

					SessionService.register($scope.user).then(
						
						->
							$state.go "index"
						->
							$scope.submiting = false
							$scope.serverError = true
													
					)
				
	



