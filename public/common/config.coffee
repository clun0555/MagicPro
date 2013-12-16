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
		$translateProvider.useMessageFormatInterpolation()
		$translateProvider.preferredLanguage 'en'



	# Handle states authentification / authorization
	app.run ($rootScope, $state, $injector, SessionService) ->

		
		$rootScope.$state = $state		

		# Enforce security when state changes
		$rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams) ->
			

			unless SessionService.isSessionFetched()
				# user state is unknown, ask server if there is an active user				
				event.preventDefault()
				SessionService.fetchSession().then(
					->
						# server has an active session. It is now stored on the client
						# re-play state to check security
						$state.go toState.name, toParams							
					->	
						$state.go toState.name, toParams
												
				)


			security = toState.data?.security
			
			if security?
				# if state has security parameters

				unless SessionService.security(security)
					# if session doesn't meet security
					event.preventDefault()

					if SessionService.user()?
						# if user is known, redirect to error page
						$state.go "error", { code: 403 }, { location: false }
					else
						# server has no active session. Ask user to login					
						$state.transitionTo "login"


			
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


		




				

