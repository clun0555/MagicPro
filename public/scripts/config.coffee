###
Defines the main routes in the application.
The routes you see here will be anchors '#/' unless specifically configured otherwise.
###
define [
	"app"
	"resources/translations/translations"
	
], (app, translations) ->
	
	app.config ($translateProvider) ->

		for tranlation in translations
			$translateProvider.translations tranlation['locale.code'], tranlation

		$translateProvider.preferredLanguage 'en'

		




				

