define [
	"underscore"
	"../admin-states"	
], (_, admin) ->

	admin.controller "UserController", ($scope, user, UserService) ->						
		$scope.user = user

		$scope.makeAdmin = ->
			$scope.user.role = "admin"
			$scope.save(  flash: "Role changed to Admin!" )

		$scope.unAdmin = ->
			$scope.user.role = "user"
			$scope.save(  flash: "Admin rights removed" )

		$scope.validate = ->
			$scope.user.status = "validated"
			$scope.save(  flash: "Validated!" )

		$scope.reject = ->
			$scope.user.status = "rejected"
			$scope.save( flash: "Rejected!" )
		
		$scope.save = ( options = {} ) ->
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
						$scope.flash  = options.flash ? "admin.user.saved"						

					->
						$scope.submiting = false
						
						# only server error currently
						$scope.serverError = "admin.email.duplicate"
				)	