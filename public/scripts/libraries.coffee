require.config

	paths:
		# "jquery": "base/lib/jquery" # cross browser Dom manipulation & Ajax calls
		
		"underscore": "base/lib/underscore/underscore" # utility belt
		# "underscore.string": "base/lib/underscore.string/underscore.string" # utility belt		

		"angular": "base/lib/angular/angular"
		"angular-route": "base/lib/angular-route/angular-route"
		"angular-resource": "base/lib/angular-resource/angular-resource"
		"angular-ui-router": "base/lib/angular-ui-router/release/angular-ui-router"
		"domReady": "base/lib/requirejs-domready/domReady"
		
		# "bootstrap": "base/lib/bootstrap" # widgets, ui guidelines
		# "moment": "base/lib/moment" # date formating		
		# "spin": "base/lib/spin"
		
		# "i18next": "base/lib/i18next" #i18n

		# "jquery-fileupload": "base/lib/jquery.fileupload" # file upload
		# "jquery.ui.widget": "base/lib/jquery.ui.widget" 

		# "text": "base/lib/require/text" # requirejs plugin to load a text resource

		# "resources": "../resources" # path to access resources
	
	# urlArgs: "bust=" + (new Date()).getTime() # prevent caching in developement but also prevent debuging :(

	shim:

		"underscore":
			exports: "_"

		'angular':
			exports: 'angular'

		'angular-route':
			deps: ['angular']

		'angular-resource':
			deps: ['angular']

		'angular-ui-router':
			deps: ['angular']


	deps: [
		'./main'
	]