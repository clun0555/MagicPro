define [
	"angular"
	"jquery"
], (ng, $) ->

	unbind = null

	ng
		.module('app.showcase', ["ui.router"])

		.config ( $stateProvider ) ->
				
			$stateProvider

				.state "showcase",
					url: "/home"
					views: "@":
						templateUrl: "app/showcase/views/home.html"
						controller: "ShowCaseHomeController"
					
					abstract: true

				.state "home",
					url: ""
					parent: "showcase"
					views:
						"showcase":
							templateUrl: "app/showcase/views/showcase.html"
							# controller: "ShowCaseCarouselController"
						"about":
							templateUrl: "app/showcase/views/about.html"
							controller: "ShowCaseAboutController"

						"contact":
							templateUrl: "app/contact/views/contact.html"
							controller: "ContactController"

						"products":
							templateUrl: "app/shop/views/categories.html"
							controller: "ShopCategoriesController"

					onEnter: ($rootScope, $state) ->

						unbind = $rootScope.$watch "currentSpy", ->
							if $rootScope.currentSpy? and not $rootScope.scrolling
								$rootScope.noScroll = true
								$state.go "home." + $rootScope.currentSpy

					onExit: ->
						unbind()

				.state "home.showcase",
					url: ""
					onEnter: ($stateParams, $state, $rootScope) -> 
						# $location.hash("contact")
						unless $rootScope.noScroll
							$rootScope.scrolling = true
							setTimeout ->
								# top = $('#contact').position().top
								$('html, body').stop().animate {scrollTop: 	0}, 800, ->
									$rootScope.scrolling = false
							,10
						
						# $rootScope.$apply ->
						$rootScope.noScroll = false

				.state "home.contact",
					url: "/contact"
					onEnter: ($stateParams, $state, $rootScope) -> 
						# $location.hash("contact")
						unless $rootScope.noScroll
							$rootScope.scrolling = true
							setTimeout ->
								top = $('#contact').position().top
								$('html, body').stop().animate {scrollTop: 	top}, 800, ->
									$rootScope.scrolling = false
							, 10

						# $rootScope.$apply ->
						$rootScope.noScroll = false

				.state "home.about",
					url: "/about"
					onEnter: ($stateParams, $state, $rootScope) -> 
						# $location.hash("contact")
						unless $rootScope.noScroll
							$rootScope.scrolling = true
							setTimeout ->
								top = $('#about').position().top
								$('html, body').stop().animate {scrollTop: 	top}, 800, ->
									$rootScope.scrolling = false
								
							, 10

						# $rootScope.$apply ->
						$rootScope.noScroll = false



				.state "about",
					url: "/about"
					views: 
						"@":
							templateUrl: "app/showcase/views/about.html"
							controller: "ShowCaseAboutController"
