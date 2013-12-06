require.config

	paths:
		
		"underscore": "base/lib/underscore/underscore" # utility belt
		"underscore.string": "base/lib/underscore.string/lib/underscore.string" # utility belt		

		# angular modules
		"angular": "base/lib/angular/angular" # main angular
		"angular-route": "base/lib/angular-route/angular-route" # basic routing
		"angular-ui-router": "base/lib/angular-ui-router/release/angular-ui-router" # angular-ui rich states/routing
		"angular-resource": "base/lib/angular-resource/angular-resource" # sync models with http rest 
		"angular-cookies": "base/lib/angular-cookies/angular-cookies" # sync models with http rest 
		"angular-translate": "base/lib/angular-translate/angular-translate" # translation
		"angular-translate-storage-cookie": "base/lib/angular-translate-storage-cookie/angular-translate-storage-cookie" # persiting translations
		
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
		"angular-cookies": ["angular"]
		"angular-translate": ["angular"]
		"angular-translate-storage-cookie": ["angular-translate", "angular-cookies"]

		"bootstrap-dropdown": ["jquery"]


	deps: [
		'./main'
	]