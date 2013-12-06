require.config

	paths:
		
		"underscore": "base/lib/underscore/underscore" # utility belt
		"underscore.string": "base/lib/underscore.string/lib/underscore.string" # utility belt		

		# angular modules
		"angular": "base/lib/angular/angular"
		"angular-route": "base/lib/angular-route/angular-route"
		"angular-resource": "base/lib/angular-resource/angular-resource"
		"angular-ui-router": "base/lib/angular-ui-router/release/angular-ui-router"
		"angular-translate": "base/lib/angular-translate/angular-translate"
		
		"domReady": "base/lib/requirejs-domready/domReady"
		
		"jquery": "base/lib/jquery/jquery" # twitter bootstrap dependency
		"bootstrap-dropdown": "base/lib/sass-bootstrap/js/dropdown" # widgets, ui guidelines
		
		# "moment": "base/lib/moment" # date formating		
		# "spin": "base/lib/spin"		
		# "jquery-fileupload": "base/lib/jquery.fileupload" # file upload
		# "jquery.ui.widget": "base/lib/jquery.ui.widget" 
		# "text": "base/lib/require/text" # requirejs plugin to load a text resource

		"resources": "/../resources" # path to access resources
	
	# urlArgs: "bust=" + (new Date()).getTime() # prevent caching in developement but also prevent debuging :(

	shim:

		"underscore":
			exports: "_"

		'angular':
			exports: 'angular'

		"angular-route": ["angular"]
		"angular-resource": ["angular"]
		"angular-ui-router": ["angular"]
		"angular-translate": ["angular"]

		"bootstrap-dropdown": ["jquery"]


	deps: [
		'./main'
	]