###
Defines the main routes in the application.
The routes you see here will be anchors '#/' unless specifically configured otherwise.
###
define [
	"jquery"
	"underscore"
	"angular"
	"app"
	"resources/translations/translations"
	"./utils/utils"
	"fastclick"
	
], ($, _, angular, app, translations, utils, FastClick) ->

	# add global utils function to underscore
	_.mixin utils

	window.addEventListener 'load', ->
		FastClick.attach(document.body)

	app.config ($translateProvider, $uiViewScrollProvider, AuthentificationServiceProvider) ->

		for translation in translations
			$translateProvider.translations translation['locale.code'], translation

		# persist current language in session
		$translateProvider.useCookieStorage()
		$translateProvider.useMessageFormatInterpolation()
		$translateProvider.preferredLanguage 'en'

		# $uiViewScrollProvider.useAnchorScroll()
#
		# AuthentificationServiceProvider.setName "rom"


		# snapRemoteProvider.globalOptions.disable = 'left'



	# Handle states authentification / authorization
	app.run ($rootScope, $state,  $stateParams, $injector, SessionService, $urlRouter ) ->

		$rootScope.info = cartVisible: false
		$rootScope.scrollPosition = 0

		
		$rootScope.$state = $state		
		$rootScope.$stateParams = $stateParams		


		$rootScope.hideDrawers = ($event) ->
			if $event
				$target = $($event.target)
				return if $target.hasClass("drawer-toggle") or $target.parents(".drawer-toggle").length or $target.hasClass("drawer") or $target.parents(".drawer").length 

			$rootScope.info.cartVisible = false if $rootScope.info.cartVisible
			$rootScope.info.leftDrawerVisible = false if $rootScope.info.leftDrawerVisible
		

		$rootScope.isRole = (roles...) ->
			SessionService.user()?.role in roles

		$rootScope.isUserValidated = ->
			SessionService.user().status is "validated"

		# add no-touch class to allow hover pseudo class to only apply on non touch devices
		isTouch = ("ontouchstart" of document.documentElement)
		touchClass = if isTouch then "touch" else "no-touch"
		document.documentElement.className += " " + touchClass		

		# Enforce security when state changes
		$rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams, $urlRouter) ->
			$rootScope.$nextState = toState
			$rootScope.nextState = toState
			
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
				return


			security = toState.data?.security
			
			if security?
				# if state has security parameters

				unless SessionService.security(security)
					# if session doesn't meet security
					event.preventDefault()

					if SessionService.isLoggedIn()
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


		$rootScope.$on '$stateChangeSuccess', (ev, to, toParams, from, fromParams) ->
			$rootScope.fromState = from
			$rootScope.fromStateParams = fromParams			


		# handle global file drop
		window.addEventListener "dragover", (e) ->
			e = e || event
			e.preventDefault()
			$("body").addClass("drag-over")
		, false 
		
		window.addEventListener "dragleave", (e) ->
			e = e || event
			e.preventDefault()
			$("body").removeClass("drag-over")

		, false 

		window.addEventListener("drop", (e) ->
			e = e || event
			e.preventDefault()
			$("body").removeClass("drag-over")
			files = e.dataTransfer.files			
			$rootScope.$broadcast("fileDrop", files)
		,false)


		




				

