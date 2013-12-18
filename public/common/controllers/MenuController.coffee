define [
	"./controllers"
	"resources/translations/translations"
], (controllers, translations) ->
	
	controllers
		.controller "MenuController", ($scope, $translate, SessionService, $state) ->

			$scope.isCollapsed = true

			$scope.logout = ->
				SessionService.logout().then -> $state.go "index"
					
	



