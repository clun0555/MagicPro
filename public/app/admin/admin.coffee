define [
	"angular"
], (ng) ->

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
					url: "/users"
					templateUrl: "app/admin/views/users.html"
					controller: "UsersController"
					resolve: 
						users: (UserService) -> UserService.findAll()

				.state "admin.user",
					url: "/users/:userId"
					templateUrl: "app/admin/views/user.html"
					controller: "UserController"
					resolve: 
						user: (UserService, $stateParams) -> UserService.find $stateParams.userId