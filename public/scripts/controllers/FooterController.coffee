define [
	"./module"
	"resources/translations/translations"
], (controllers, translations) ->
	
	controllers
		.controller "FooterController", ($scope, $translate) ->
			
			$scope.translations = 
				for locale in translations
					label: locale["locale.label"], code: locale["locale.code"]

			$scope.translate = (locale) ->
				$translate.uses(locale.code)		
	



