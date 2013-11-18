define [
	"jquery"
	"underscore"
	"App"
	"i18next"
	"text!resources/locales/locales.json"
], ($, _, App, i18n, jsonLocales) ->

	locales = JSON.parse jsonLocales

	# loads translation files depending on user locale. Returns a promise
	App.reqres.setHandler "translator:load", ->
		job = $.Deferred()
		
		i18n.init {	
			resGetPath: '/resources/locales/${ns}-${lng}.json'
			lowerCaseLng: true
			interpolationPrefix: '${'
			interpolationSuffix: '}'
		}, -> 
			job.resolve()
		
		job

	# changes local and returns a promise
	App.reqres.setHandler "translator:locale:change", (locale) ->
		job = $.Deferred()		
		i18n.setLng locale, -> 
			job.resolve()
			App.vent.trigger "translator:locale:changed", locale
		job

	# returns the list of available locales
	App.reqres.setHandler "translator:locales:list", -> locales
	
	# returns the current locale
	App.reqres.setHandler "translator:locales:current", -> 
		# i.lng() returns en-us. We only want en
		localeCode = i18n.lng().split("-")[0]
		_.find locales, (locale) -> locale.code is localeCode
		
	# translate function. see http://i18next.com/ for documentation
	t: i18n.t

	# date format function
	d: (format) -> # implement localized date formating

