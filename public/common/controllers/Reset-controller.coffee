define [
	"./controllers"
	"resources/translations/translations"
], (controllers, translations) ->
	
	controllers
		.controller "ResetController", ($scope, $state, $stateParams, SessionService, UserService, $parse, user) ->
			
			$scope.lostUser = user

			$scope.forgot = ->
				$scope.errors = {}
				$scope.submited = true
				
				$scope.resetServerError = -> 
					$scope.serverError = false

				$scope.resetServerError()

				if $scope.credentials.$valid
					$scope.submiting = true

					UserService.reset( { forgotKey: $stateParams.forgotKey, password: $scope.lostUser.password } ).then(						
						(user) ->
							# $state.go "index"
							SessionService.login(user.email, $scope.lostUser.password).then ->
								$state.go "index"
							
						->
							$scope.submiting = false
							$scope.serverError = true
													
					)
				
	



