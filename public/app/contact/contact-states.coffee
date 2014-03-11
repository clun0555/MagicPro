define [
	"angular"
], (ng) ->

	ng
		.module('app.contact', ["ui.router"])

		.config ( $stateProvider ) ->
				
			$stateProvider

				.state "contact",
					url: "/contact"
					templateUrl: "app/contact/views/contact.html"
					controller: "ContactController"
					parent: "layout"					
