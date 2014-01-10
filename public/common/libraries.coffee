require.config
	
	baseUrl: "/"

	paths:
		
		"underscore": "vendor/underscore/underscore" # utility belt
		"underscore.string": "vendor/underscore.string/lib/underscore.string" # utility belt		

		# angular modules
		"angular": "vendor/angular/angular" # main angular
		"angular-route": "vendor/angular-route/angular-route" # basic routing
		"angular-animate": "vendor/angular-animate/angular-animate" # persiting translations
		"angular-bootstrap": "vendor/angular-bootstrap/ui-bootstrap-tpls" # bootstrap and angular integration
		"angular-ui-router": "vendor/angular-ui-router/release/angular-ui-router" # angular-ui rich states/routing
		"angular-resource": "vendor/angular-resource/angular-resource" # sync models with http rest 
		"angular-cookies": "vendor/angular-cookies/angular-cookies" # sync models with http rest 
		"angular-translate": "vendor/angular-translate/angular-translate" # translation
		"angular-translate-storage-cookie": "vendor/angular-translate-storage-cookie/angular-translate-storage-cookie" # persiting translations
		"angular-translate-interpolation-messageformat": "vendor/angular-translate-interpolation-messageformat/angular-translate-interpolation-messageformat" # persiting translations
		"messageformat": "vendor/messageformat/messageformat" # pluralization / genders
		"messageformat-zh": "vendor/messageformat/locale/zh" # pluralization / genders
		# "messageformat-en": "vendor/messageformat/locale/en" # persiting translations		
		
		"domReady": "vendor/requirejs-domready/domReady"
		
		"jquery": "vendor/jquery/jquery" # twitter bootstrap dependency
		"bootstrap-dropdown": "vendor/sass-bootstrap/js/dropdown" # widgets, ui guidelines

		"angular-file-upload": "vendor/angular-file-upload/angular-file-upload"
		
		# FILE UPLOAD ... thank god all is concatenated at build time :)
		# "jquery.fileupload": "vendor/jquery-file-upload/js/jquery.fileupload" # file upload dependency
		# "jquery.fileupload-angular": "vendor/jquery-file-upload/js/jquery.fileupload-angular" # file upload dependency
		# "jquery.fileupload-process": "vendor/jquery-file-upload/js/jquery.fileupload-process" # file upload dependency
		# "jquery.fileupload-audio": "vendor/jquery-file-upload/js/jquery.fileupload-audio" # file upload dependency
		# "jquery.fileupload-audio": "vendor/jquery-file-upload/js/jquery.fileupload-audio" # file upload dependency
		# "jquery.fileupload-video": "vendor/jquery-file-upload/js/jquery.fileupload-video" # file upload dependency
		# "jquery.fileupload-validate": "vendor/jquery-file-upload/js/jquery.fileupload-validate" # file upload dependency
		# "jquery.fileupload-image": "vendor/jquery-file-upload/js/jquery.fileupload-image" # file upload dependency
		# "load-image": "vendor/blueimp-load-image/js/load-image" # file upload dependency
		# "load-image-meta": "vendor/blueimp-load-image/js/load-image-meta" # file upload dependency
		# "load-image-exif": "vendor/blueimp-load-image/js/load-image-exif" # file upload dependency
		# "load-image-ios": "vendor/blueimp-load-image/js/load-image-ios" # file upload dependency
		# "load-image-orientation": "vendor/blueimp-load-image/js/load-image-orientation" # file upload dependency
		# "canvas-to-blob": "vendor/blueimp-canvas-to-blob/js/canvas-to-blob" # file upload dependency
		# "jquery.ui.widget": "vendor/jquery-file-upload/js/vendor/jquery.ui.widget" 

		# "text": "vendor/require/text" # requirejs plugin to load a text resource
		# "resources": "/resources" # path to access resources

	
	# urlArgs: "bust=" + (new Date()).getTime() # prevent caching in developement but also prevent debuging :(

	shim:

		"underscore":
			exports: "_"
			deps: ["underscore.string"]
			init: (_str) ->
				this._.mixin(_str.exports())


		'angular':
			deps: ["messageformat"]
			exports: 'angular'
			init: (MessageFormat) ->
				# not very clean... 
				# setting messageformat in deps doesn't work for some reasom
				window.MessageFormat = MessageFormat
				window.MessageFormat.locale.zh = ( n ) ->  "other"
				this.angular

		"angular-route": ["angular"]
		"angular-animate": ["angular"]
		"angular-bootstrap": ["angular"]
		"angular-resource": ["angular"]
		"angular-ui-router": ["angular"]
		"angular-cookies": ["angular"]
		"angular-translate": ["angular"]
		"angular-translate-storage-cookie": ["angular-translate", "angular-cookies"]
		"angular-translate-interpolation-messageformat": ["angular-translate"]		

		# "jquery.ui.widget": ["jquery"]

		# "jquery.fileupload": ["jquery.ui.widget", "load-image"]
		# "jquery.fileupload-process": ["jquery.fileupload"]
		# "jquery.fileupload-angular": ["angular", "jquery.fileupload"]
		
		# "messageformat-en": ["messageformat"]

		"angular-file-upload": ["angular", "jquery"]
			
		"bootstrap-dropdown": ["jquery"]

		