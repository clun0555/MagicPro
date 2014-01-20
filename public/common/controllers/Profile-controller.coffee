define [
	"./controllers"	
], (controllers) ->
	
	controllers.controller "ProfileController", ($scope, $state, SessionService, UserService, $stateParams, user) ->
		$scope.user = user

		$scope.save = ( options = {} ) ->

			$scope.errors = {}
			$scope.submited = true
			$scope.serverError = null
			
			$scope.resetServerError = -> 
				$scope.serverError = false

			$scope.resetServerError()

			if $scope.credentials.$valid
				$scope.submiting = true

				UserService.save($scope.user).then(
					->
						$scope.submiting = false
						$scope.flash  = options.flash ? "profile.saved"					

					->
						# only server error currently
						$scope.serverError = "profile.email.duplicate"
						
						$scope.submiting = false
						
				)

