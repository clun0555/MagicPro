define [
	"./admin"
], (admin) ->
	
	admin
		
		.controller "UsersController", ($scope, users, UserService) ->						
			$scope.users = users

			$scope.removeUser = (user) ->
				UserService.remove(user).then ->
					index = $scope.users.indexOf user
					$scope.users.splice index, 1

		# .controller "UserCreateController", ($scope, UserService) ->
		# 	$scope.user = {}

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

						
				

			

	



