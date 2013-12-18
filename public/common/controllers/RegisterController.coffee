define [
	"./controllers"
	"resources/translations/translations"
], (controllers, translations) ->
	
	controllers
		.controller "RegisterController", ($scope, $state, SessionService, $parse) ->
			
			$scope.toto = "helo"

			$scope.register = ->
				$scope.errors = {}
				$scope.submited = true
				
				$scope.resetServerError = -> 
					$scope.serverError = false

				$scope.resetServerError()

				if $scope.credentials.$valid

					SessionService.register($scope.user).then(
						
						->
							$state.go "index"
						->
							$scope.serverError = true
													
					)
				
	



