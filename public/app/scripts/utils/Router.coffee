
define [
	"underscore"
	"App"
	"marionette"
	"utils/ApplicationController"

], (_, App, Marionette, ApplicationController) ->
	
	class Router extends Marionette.AppRouter

		controller: ApplicationController

		appRoutes:
			"login": "login" 
			"register": "register" 
			"products": "products"
			"*path" : "root"

		constructor: ->
			super
			@hookControllerRoutes()

		# keeps routes up do date when controllers are called directly		
		hookControllerRoutes: ->
			for route, method of @appRoutes when route isnt "*path"
				do (route, method) =>
					@controller[method] = _.wrap @controller[method], (func, arg1, arg2, arg3, arg4, arg5) =>
						@navigate(route, {trigger:false})
						func.call(@controller, arg1, arg2, arg3, arg4, arg5)


