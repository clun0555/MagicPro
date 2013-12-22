define [
	"./admin"
], (admin) ->
	
	admin
		
		.controller "UsersController", ($scope, users) ->						
			$scope.users = users

		.controller "UserController", ($scope, user, UserService) ->						
			$scope.user = user		

			$scope.changeRole = (role) ->
				$scope.user.role = role


			$scope.save = ->
				$scope.errors = {}
				$scope.submited = true
				
				$scope.resetServerError = -> 
					$scope.serverError = false

				$scope.resetServerError()

				if $scope.credentials.$valid
					$scope.submiting = true

					UserService.save($scope.user).then(
						->
							$scope.submiting = false
							$scope.flash  = "Saved!"

						->
							$scope.submiting = false
							$scope.flash = "Ooops"
					)

						
				

			

	



