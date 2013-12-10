###
Defines the main routes in the application.
The routes you see here will be anchors '#/' unless specifically configured otherwise.
###
define [
	"angular"
	"app"
	"resources/translations/translations"
	
], (angular, app, translations) ->

	app.config ($translateProvider) ->

		# $anchorScrollProvider.disableAutoScrolling()

		

		for tranlation in translations
			$translateProvider.translations tranlation['locale.code'], tranlation

		# persist current language in session
		$translateProvider.useCookieStorage()
		
		$translateProvider.preferredLanguage 'en'


	# Handle states authentification / authorization
	app.run ($rootScope, $state, $injector, SessionService) ->

		$rootScope.hello = "world"

		$rootScope.$state = $state		

		# Enforce security when state changes
		$rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
			security = toState.data?.security
			
			if security?
				# if state has security parameters

				if SessionService.get()?
					# if there is an active session	
					
					unless SessionService.security(security)
						# if session doesn't meet security, redirect to error page
						event.preventDefault()
						$state.go "error", { code: 403 }, { location: false }

				else
					# no active session yet, ask server				
					event.preventDefault()
					SessionService.fetchSession().then(
						->
							# server has an active session. It is now stored on the client
							# re-play state to check security
							$state.go toState.name, toParams							
						->	
							# server has no active session. Ask user to login					
							$state.transitionTo "login"
					)
			
		# Hanlle state change errors. ex: Resolver got rejected.  		
		$rootScope.$on "$stateChangeError", (event, toState, toParams, fromState, fromParams, error) ->
			
			# if we dont have a error code. Must be a technical error
			code = error?.code ? 500 
			
			if code is 401
				# a resolver returned a 401 (Unauthorized). Redirect to login page
				$state.go "login"
			else
				# Any other types of errors redirects to error page
				$state.go "error", { code: code }, { location: false }


		




				

