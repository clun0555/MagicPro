define [
	"angular"
], (ng) ->

	ng
		.module('app.admin', ["ui.router"])

		.config ( $stateProvider ) ->
				
			$stateProvider

				.state "admin",
					url: "/admin"
					data: security: "admin"
					templateUrl: "app/admin/views/admin.html"		
									
			
