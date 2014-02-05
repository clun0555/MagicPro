define [
	"./controllers"
	"resources/translations/translations"
], (controllers, translations) ->
	
	# map server error to client error description
	msgs = 
		'user.username.incorrect' : "login.email.notfound"
		'user.password.incorect' : "login.password.incorect"

	controllers
		.controller "LoginController", ($scope, $state, SessionService, $parse, AuthentificationService) ->
			
			AuthentificationService.greet()

			$scope.login = ->
				$scope.errors = {}
				$scope.submited = true				
				
				$scope.resetServerError = -> 
					$scope.serverError = false

				$scope.resetServerError()

				if $scope.credentials.$valid

					$scope.submiting = true

					SessionService.login($scope.email, $scope.password).then(
						
						->
							$state.go "index"
						
						(err) ->
							
							$scope.submiting = false
							$scope.serverError = msgs[err.message]
																			
					)
				
	



