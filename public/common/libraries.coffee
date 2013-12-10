require.config
	
	baseUrl: "/"

	paths:
		
		"underscore": "vendor/underscore/underscore" # utility belt
		"underscore.string": "vendor/underscore.string/lib/underscore.string" # utility belt		

		# angular modules
		"angular": "vendor/angular/angular" # main angular
		"angular-route": "vendor/angular-route/angular-route" # basic routing
		"angular-animate": "vendor/angular-animate/angular-animate" # persiting translations
		"angular-ui-router": "vendor/angular-ui-router/release/angular-ui-router" # angular-ui rich states/routing
		"angular-resource": "vendor/angular-resource/angular-resource" # sync models with http rest 
		"angular-cookies": "vendor/angular-cookies/angular-cookies" # sync models with http rest 
		"angular-translate": "vendor/angular-translate/angular-translate" # translation
		"angular-translate-storage-cookie": "vendor/angular-translate-storage-cookie/angular-translate-storage-cookie" # persiting translations
		
		"domReady": "vendor/requirejs-domready/domReady"
		
		"jquery": "vendor/jquery/jquery" # twitter bootstrap dependency
		"bootstrap-dropdown": "vendor/sass-bootstrap/js/dropdown" # widgets, ui guidelines
		
		# "moment": "vendor/moment" # date formating		
		# "spin": "vendor/spin"		
		# "jquery-fileupload": "vendor/jquery.fileupload" # file upload
		# "jquery.ui.widget": "vendor/jquery.ui.widget" 
		# "text": "vendor/require/text" # requirejs plugin to load a text resource

		# "resources": "/resources" # path to access resources

	
	# urlArgs: "bust=" + (new Date()).getTime() # prevent caching in developement but also prevent debuging :(

	shim:

		"underscore":
			exports: "_"

		'angular':
			exports: 'angular'

		"angular-route": ["angular"]
		"angular-animate": ["angular"]
		"angular-resource": ["angular"]
		"angular-ui-router": ["angular"]
		"angular-cookies": ["angular"]
		"angular-translate": ["angular"]
		"angular-translate-storage-cookie": ["angular-translate", "angular-cookies"]

		"bootstrap-dropdown": ["jquery"]

		