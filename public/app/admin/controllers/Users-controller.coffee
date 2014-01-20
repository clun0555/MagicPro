define [
	"underscore"
	"../admin-states"	
], (_, admin) ->

	admin.controller "UsersController", ($scope, users, UserService, $modal) ->						
		$scope.users = users

		$scope.removeUser = (user) ->
			UserService.remove(user).then ->
				index = $scope.users.indexOf user
				$scope.users.splice index, 1	