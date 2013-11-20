require.config

	paths:
		"jquery": "base/lib/jquery" # cross browser Dom manipulation & Ajax calls
		"underscore": "base/lib/underscore" # utility belt
		
		"backbone": "base/lib/backbone" # MVC Framework
		"marionette": "base/lib/backbone.marionette" # Reusable Large Scale Application Design Patterns
		"backbone.named.routes": "base/lib/backbone.named.routes" # plugin to extract routes url 
		
		"bootstrap": "base/lib/bootstrap" # widgets, ui guidelines
		"moment": "base/lib/moment" # date formating
		
		"spin": "base/lib/spin"
		
		"i18next": "base/lib/i18next" #i18n

		"jquery-fileupload": "base/lib/jquery.fileupload" # file upload
		"jquery.ui.widget": "base/lib/jquery.ui.widget" 

		"text": "base/lib/require/text" # requirejs plugin to load a text resource

		"resources": "../resources" # path to access resources
	
	# urlArgs: "bust=" + (new Date()).getTime() # prevent caching in developement but also prevent debuging :(

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

		"backbone.named.routes": ["backbone"]