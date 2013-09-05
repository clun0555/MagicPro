require.config

	paths:
		"jquery": "base/lib/jquery" # cross browser Dom manipulation & Ajax calls
		"underscore": "base/lib/underscore" # utility belt
		
		"backbone": "base/lib/backbone" # MVC Framework
		"marionette": "base/lib/backbone.marionette" # Reusable Large Scale Application Design Patterns
		
		"bootstrap": "base/lib/bootstrap" # widgets, ui guidelines
		"moment": "base/lib/moment" # date formating
		
		"spin": "base/lib/spin"

		"i18next": "base/lib/i18next" #i18n

		"text": "base/lib/require/text" # requirejs plugin to load a text resource

		"resources": "/dist/resources" # path to access resources
	
	shim:

		"underscore":
			exports: "_"

		"backbone":
			deps: ["jquery", "underscore"]
			exports: "Backbone"

		"bootstrap":
			deps: ["jquery"]

		"marionette":
			exports: "Backbone.Marionette"
			deps: ["backbone"]