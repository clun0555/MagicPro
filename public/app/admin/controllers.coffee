define [
	"./admin-states"
], (admin) ->
	
	admin
		
		.controller "UsersController", ($scope, users, UserService, $modal) ->						
			$scope.users = users

			$scope.removeUser = (user) ->
				UserService.remove(user).then ->
					index = $scope.users.indexOf user
					$scope.users.splice index, 1

			# $scope.open = ->
			# 	modalInstance = $modal.open(
			# 		templateUrl: "admin.new.html"
			# 		controller: ModalInstanceCtrl
			# 		resolve:
			# 			items: ->
			# 				$scope.items
			# 	)
			# 	modalInstance.result.then ((selectedItem) ->
			# 		$scope.selected = selectedItem
			# 	), ->
			# 		$log.info "Modal dismissed at: " + new Date()


		# .controller "UserCreateController", ($scope, UserService) ->
		# 	$scope.user = {}

		.controller "UserController", ($scope, user, UserService, FileUploadService) ->						
			$scope.user = user

			$scope.uploader = FileUploadService.newUploader($scope)

			# $scope.save = ->
			# 	item.update().then ->
					

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

			$scope.close = ->
				$scope.$dismiss("cancel")

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
							$scope.flash  = options.flash ? "Saved!"
							# modal	
							$scope.$close true

						->
							$scope.submiting = false
							$scope.flash = "Ooops"
					)

						
				

			

	



