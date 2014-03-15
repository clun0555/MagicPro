define [
	"angular"
], (ng) ->

	ng
		.module('app.showcase', ["ui.router"])

		.config ( $stateProvider ) ->
				
			$stateProvider

				.state "home",
					url: "/home"
					templateUrl: "app/showcase/views/home.html"
					controller: "ShowCaseHomeController"
					parent: "layout"			

				.state "about",
					url: "/about"
					templateUrl: "app/showcase/views/about.html"
					controller: "ShowCaseAboutController"
					parent: "layout"					
