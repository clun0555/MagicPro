define [
	"App"
	"underscore"
	"backbone"
], (App, _, Backbone) ->
	
	class Router extends Backbone.Router

		constructor: (options) ->
			super options

			# add routes to backbone.named.routes
			for route, method of @routes when route isnt "*path"
				@helper.addRoute method, route

			# when route changes, change state
			@on "route", (route, args) =>
				App.navigate route, args

			# when state changes, keep url up-to-date
			App.state.on "navigate", (action, args, options) =>				
										
				# retrieve path from action and arguments
				path = @path action, args
				
				if path
					# translate options to router options
					routerOptions = { trigger: false, update: false }
					routerOptions.replace = true if options?.history is false

					# navigate silently to path
					@navigate path, routerOptions


		# return the path for a route and arguments. 
		path: (route, args) ->
			
			# remove all object literals or arrays.
			args = _.chain(args).compact().filter( (value) -> not (_.isObject(value) or _.isArray(value)) ).value()
			
			# call router helper to get route path using backbone.named.routes
			try
				return @helper[route + "Path"].apply @helper, args
			catch
				return false
				# # fallback to route without params if no routes has matched
				# try
				# 	return @helper[route + "Path"].apply @helper
				# catch 


		

					
		