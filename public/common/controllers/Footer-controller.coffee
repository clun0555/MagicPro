define [
	"./controllers"
	"resources/translations/translations"
], (controllers, translations) ->
	
	controllers
		.controller "FooterController", ($scope, $translate, SessionService, $state) ->
			
			$scope.translations = 
				for locale in translations
					label: locale["locale.label"], code: locale["locale.code"]

			$scope.translate = (locale) ->
				$translate.uses(locale.code)		

			$scope.logout = ->
				SessionService.logout().then -> $state.go "login"
					
	



