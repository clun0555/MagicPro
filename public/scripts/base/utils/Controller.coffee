define [
	"App"
	"marionette"
	"base/utils/Router"
	"utils/Authorization"
], (App, Marionette, Router, Authorization) ->
	
	class Controller extends Marionette.Controller

		constructor: (options) ->
			super options

			{ @region } = options

			@createRoute()

			# Handler to App.execute "<controllerName>", <actionName>, params...
			App.commands.setHandler @camelToEvent(@controllerName()) , (action, arg1, arg2, arg3, arg4, arg5) =>
				console.log "execute" + action
				@run @eventToCamel(action), arg1, arg2, arg3, arg4, arg5

		controllerName: -> @constructor.name		

		createRoute: ->
			
			return unless @routes

			# create Router Class
			ControllerRouter = Router.extend routes: @routes
			
			# instanciate Router and hook it to this controller
			@router = new ControllerRouter()

			for route, method of @routes

				do (route, method) =>

					@router.on "route:#{method}", (arg1, arg2, arg3, arg4, arg5) =>
						# call controller 
						@run method, arg1, arg2, arg3, arg4, arg5

					if route isnt "*path"
						# keep router up to date
						@on @camelToEvent(method), (arg1, arg2, arg3, arg4, arg5) =>
							@router.navigate @router.path(method, arg1, arg2, arg3, arg4, arg5), {trigger:false}

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
		before: (action, arg1, arg2, arg3, arg4, arg5) -> true

		run: (action, arg1, arg2, arg3, arg4, arg5) ->

			console.log action, arguments

			# trigger event
			@trigger @camelToEvent(action), arg1, arg2, arg3, arg4, arg5

			return false if @enforceAuthorization(action, arg1, arg2, arg3, arg4, arg5) is false

			return false if @before?(action, arg1, arg2, arg3, arg4, arg5) is false

			# execute action
			this[action]?(arg1, arg2, arg3, arg4, arg5) 

		
		enforceAuthorization: (action, arg1, arg2, arg3, arg4, arg5) ->
			
			return true if @authorize(action)

			# user is not authorized
			if App.user?
				# user is logged in. Show a 403 Forbiden page
				App.execute "application:controller", "show:error:page", 403 
			else
				console.log "not logged"
				console.log [ @camelToEvent(@controllerName()), @camelToEvent(action),  arg1, arg2, arg3, arg4, arg5]
				# user isnt logged in. Request a login and forward back
				App.execute "application:controller", "login", [ @camelToEvent(@controllerName()), @camelToEvent(action),  arg1, arg2, arg3, arg4, arg5]

			return false

		# keeps routes up do date when controllers are called directly
		hookControllerRoutes: ->
			
			for route, method of @routes when route isnt "*path"

				do (route, method) =>
					
					@controller[method] = _.wrap @controller[method], (func, arg1, arg2, arg3, arg4, arg5) =>
						@navigate @path(method, arg1, arg2, arg3, arg4, arg5), {trigger:false}
						func.call @controller, arg1, arg2, arg3, arg4, arg5

					@on "route:#{method}", (arg1, arg2, arg3, arg4, arg5) =>
						# call controller 
						@controller.run method, arg1, arg2, arg3, arg4, arg5


	# mixin authorization methods
	_.extend Controller.prototype, Authorization

	Controller
				
