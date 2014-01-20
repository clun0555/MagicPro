define [
	"./controllers"	
], (controllers) ->
	
	msgs = 
		'user.username.incorrect' : "login.email.notfound"
		'user.password.incorect' : "login.password.incorect"

	controllers.controller "PasswordChangeController", ($scope, $state, SessionService, UserService, $stateParams, user) ->
		$scope.user = user

		$scope.save = ( options = {} ) ->

			$scope.errors = {}
			$scope.submited = true
			$scope.passwordChanged = false
			
			$scope.resetServerError = ->  $scope.serverError = false

			$scope.resetServerError()

			if $scope.credentials.$valid
				$scope.submiting = true

				UserService.reset(email: user.email, currentPassword: $scope.currentPassword, newPassword: $scope.newPassword).then(
					->
						# reset all fields if form is used again
						$scope.submiting = false
						$scope.submited = false
						$scope.passwordChanged = true	
						$scope.newPassword = null
						$scope.currentPassword = null
						$scope.serverError = null

					(err) ->
						$scope.serverError = msgs[err.message.message]
						$scope.submiting = false						
				)

