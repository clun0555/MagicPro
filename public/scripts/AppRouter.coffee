define [
	"Base"
	"App"
], (Base, App) ->

	class AppRouter extends Base.Router

		routes: 

			"": "app:root"
			"login": "app:login"
			"register": "app:register"
			
			"products": "product:show:categories"
			"products/:categorieIdentifier": "product:show:types"
			"products/:categorieIdentifier/:typeIdentifier": "product:show:products"
			"products/:categorieIdentifier/:typeIdentifier/:productIdentifier": "product:show:product"


		constructor: ->
			super
			
			@on "route", (route, args) =>
				App.navigate @camelToEvent(route), args

			App.state.on "navigate", (action, args, options) =>				
				# This handler keeps the url up to date.

				route = action # @eventToCamel(action)
										
				# retrieve path from action and arguments
				path = @path route, args
				
				if path
					# translate options to router options
					routerOptions = { trigger: false, update: false }
					routerOptions.replace = true if options?.history is false

					# navigate silently to path
					@navigate path, routerOptions


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
