define [
	"App"
	"jquery"
	"marionette"
	"base/utils/Router"
	"utils/Authorization"
], (App, $, Marionette, Router, Authorization) ->
	
	class Controller extends Marionette.Controller

		constructor: (options) ->
			super options

			{ @region } = options

			@createRoute()

			# Handler to App.execute "<controllerName>", <actionName>, args...
			App.commands.setHandler @camelToEvent(@controllerName()) , (action, args, options) =>
				@run @eventToCamel(action), args, options

		controllerName: -> 
			# uglifyjs can mess with class name causing this to break. C
			# currently option is set to mangle:false to avoid this problem
			@constructor.name		

		createRoute: ->
			
			return unless @routes

			# create Router Class
			ControllerRouter = Router.extend routes: @routes
			
			# instanciate Router and hook it to this controller
			@router = new ControllerRouter()

			for route, method of @routes

				do (route, method) =>

					# handler when route is entered from URL
					@router.on "route:#{method}", =>
						@run method, _.chain(arguments).compact().value()

					if route isnt "*path"
						
						# This handler keeps the url up to date if controller is called manualy. Has no effect otherwise
						@on @camelToEvent(method), (args, options) =>
							
							# retrieve path from controller, action and arguments
							path = @router.path(method, args)
							
							# translate options to router options
							routerOptions = { trigger: false, update: false }
							routerOptions.replace = true if options?.history is false

							# navigate silently to path
							@router.navigate path, routerOptions

		# converts camelCase to event name. ex: showUsers -> show:users
		camelToEvent: (str) ->
			str.replace(/([a-z])([A-Z])/g, '$1:$2').toLowerCase()


		# converts event name to camel casse. ex: show:users -> showUsers 
		eventToCamel: (str) ->
			# split the event name on the :
			splitter = /(^|:)(\w)/gi

			# take the event section ("section1:section2:section3")
			# and turn it in to uppercase name
			getEventName = (match, prefix, eventName)  -> if prefix is "" then eventName else eventName.toUpperCase()

			str.replace(splitter, getEventName)


		# show a view in controllers region
		show: (view) ->
			@region.show view

		# override for custom authorization
		authorize: (action) -> true

		# overide for any action to perform before controler
		before: (action, args) -> true

		run: (action, args, options) ->

			console.debug "running action #{action}:", arguments

			# trigger event
			@trigger @camelToEvent(action), args, options

			return false if @enforceAuthorization(action, args) is false

			return false if @before?(action, args) is false

			# execute action
			this[action].apply this, args

			@after?(action, args)

		
		enforceAuthorization: (action, args) ->
			
			return true if @authorize(action)

			# user is not authorized

			if App.user?
				# user is logged in. Use is not allowed to see page. Show a 403 Forbiden page
				App.execute "application:controller", "show:error:page", [ 403 ], history: false
			else
				# user isnt logged in. Might be allowed but needs to login first. Request a login and forward back
				App.execute "application:controller", "login", [ [ @camelToEvent(@controllerName()), @camelToEvent(action),  args] ], history: false

			return false	

		# helper method to update document's title
		title: (title) ->
			$(document).attr 'title', title


	# mixin authorization methods
	_.extend Controller.prototype, Authorization

	Controller
				
