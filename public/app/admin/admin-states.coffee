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
					parent: "layout"

				.state "admin.users",
					url: "/users?status"
					templateUrl: "app/admin/views/users.html"
					controller: "UsersController"
					resolve: 
						users: (UserService, $stateParams) -> 
							
							query = status: ( $stateParams.status ? 'validated' )
							
							UserService.findAll query
						

				.state "admin.new",
					url: "/new"
					templateUrl: "app/admin/views/user.html"
					controller: "UserController"
					resolve:
						user: -> { role: "user", status: "validated" }				
					
				.state "admin.user",
					url: "/users/:userId"
					templateUrl: "app/admin/views/user.html"
					controller: "UserController"
					resolve:
						user: (UserService, $stateParams) -> UserService.find $stateParams.userId								
						

