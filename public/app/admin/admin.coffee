define [
	"angular"
], (ng) ->

	userEditModal = null

	ng
		.module('app.admin', ["ui.router"])

		.config ( $stateProvider, $urlRouterProvider ) ->

			$urlRouterProvider.when('/admin', '/admin/users')
				
			$stateProvider

				.state "admin",
					url: "/admin"
					data: security: "admin"
					templateUrl: "app/admin/views/admin.html"

				.state "admin.users",
					url: "/users?status"
					templateUrl: "app/admin/views/users.html"
					controller: "UsersController"
					resolve: 
						users: (UserService, $stateParams) -> 
							
							query = status: $stateParams.status if $stateParams.status? 
							
							UserService.findAll query
						

				.state "admin.new",
					url: "/new"
					templateUrl: "app/admin/views/user.html"
					controller: "UserController"
					resolve:
						user: -> { role: "user", status: "validated" }

				# .state "admin.users.new",
				# 	url: "/new"
				# 	onEnter: ($stateParams, $state, $modal, $resource) ->
				# 		userEditModal = $modal.open(							
				# 			templateUrl: "app/admin/views/user.html"
				# 			controller: "UserController"
				# 			resolve:
				# 				user: -> { role: "user", status: "validated" }
							
				# 		)

				# 		userEditModal.result.finally (result) ->
				# 			$state.transitionTo "admin.users", {}

						

				# 	onExit: ($modal) ->
				# 		# close modal when navigating away
				# 		userEditModal.dismiss()
				# 		# userEditModal = null
					
				.state "admin.user",
					url: "/users/:userId"
					templateUrl: "app/admin/views/user.html"
					controller: "UserController"
					resolve:
						user: (UserService, $stateParams) -> UserService.find $stateParams.userId


					# onEnter: ($stateParams, $state, $modal, $resource) ->
					# 	$modal.open(
							
							
					# 	).result.then (result) ->
					# 		$state.transitionTo "admin.users"					
						


				# .state "admin.user",
				# 	url: "/users/:userId"
				# 	onEnter: ($stateParams, $state, $modal, $resource) ->
				# 		$modal.open(
				# 			templateUrl: "app/admin/views/user.html"
				# 			controller: "UserController"
				# 			resolve:
				# 				user: (UserService, $stateParams) -> UserService.find $stateParams.userId
							
				# 		).result.then (result) ->
				# 			$state.transitionTo "admin.users"					
						

