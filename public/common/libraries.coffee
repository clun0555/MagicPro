require.config
	
	baseUrl: "/"

	paths:
		
		"underscore": "vendor/underscore/underscore" # utility belt
		"underscore.string": "vendor/underscore.string/lib/underscore.string" # utility belt		

		"fastclick": "vendor/fastclick/lib/fastclick"

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
		"angular-bindonce": "vendor/angular-bindonce/bindonce" # one way binding		
		
		"ng-fittext": "vendor/ng-FitText.js/ng-FitText" # 
		"medium-editor": "vendor/medium-editor/dist/js/medium-editor" # 
		
		
		"messageformat": "vendor/messageformat/messageformat" # pluralization / genders
		"messageformat-zh": "vendor/messageformat/locale/zh" # pluralization / genders
		# "messageformat-en": "vendor/messageformat/locale/en" # persiting translations		
		
		"domReady": "vendor/requirejs-domready/domReady"
		
		"jquery": "vendor/jquery/jquery" # twitter bootstrap dependency
		
		"angular-file-upload": "vendor/angular-file-upload/angular-file-upload"

		"ng-infinite-scroll": "vendor/ngInfiniteScroll/ng-infinite-scroll"
		
		"angular-mocks": "vendor/angular-mocks/angular-mocks"

		"q": "vendor/q/q"
		
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
			deps: ["messageformat", "jquery"]
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
		"angular-file-upload": ["angular", "jquery"]
		"angular-mocks": ["angular"]
		"angular-bindonce": ["angular"]

		"ng-fittext": ["angular"]

		"medium-editor":
			exports: "MediumEditor"

		"ng-infinite-scroll": ["angular", "jquery"]
			
		# "bootstrap-dropdown": ["jquery"]

		