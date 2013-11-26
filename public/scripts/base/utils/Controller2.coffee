define [
	"underscore"
	"App"
	"jquery"
	"marionette"	
	"utils/Authorization"
	
], (_, App, $, Marionette, Authorization) ->
	
	class Controller extends Marionette.Controller

		initialize: (options) ->

			{ @region } = options

			@subControllers = []

			@listenTo App.state, "navigate", @handleStateChange
						

		handleStateChange: (state, args) ->
			actionName = @states[state]
				
			if actionName? and this[actionName]?
				
				console.debug @controllerName() + "::" + actionName + " responding to state " + state, args
				
				@run actionName, args				

		controllerName: -> 
			# uglifyjs can mess with class name causing this to break.
			# currently option is set to mangle:false to avoid this problem
			@constructor.name		

		authorize: (action) -> true


		do: (cjobs, cb) ->
			
			actionFunction = arguments.callee.caller
			action = _.find _.keys(this.constructor.prototype), (key) => this[key] is actionFunction
			
			$.when(cjobs...)
				.done =>		
					cb.apply this, _.compact(arguments)
				.fail =>
					App.navigate "app:show:error:page", [ 403 ], history: false

		run: (action, args, options) ->

			# trigger event
			@trigger @camelToEvent(action), args, options

			return false if @enforceAuthorization(action, args) is false

			return false if @before?(action, args) is false

			# execute action
			this[action].apply this, args

			@after?(action, args)

		# show a view in controllers region
		show: (view) ->
			@region.show view

		enforceAuthorization: (action, args) ->
			
			return true if @authorize(action)

			# user is not authorized

			if App.user?
				# user is logged in. Use is not allowed to see page. Show a 403 Forbiden page
				App.navigate "app:show:error:page", [ 403 ], history: false
			else
				# user isnt logged in. Might be allowed but needs to login first. Request a login and forward back
				App.navigate "app:login", [ [ @camelToEvent(@controllerName()), @camelToEvent(action),  args] ], history: false

			return false


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

		sub: (subController) ->
			@subControllers.push subController
			#manualy propagate current state to sub controllers
			subController.handleStateChange App.state.get("state"), App.state.get("args")

		closeSubControllers: ->
			subController.close() for subController in @subControllers

		onCose: ->
			# make sure to close subControllers in 
			@closeSubControllers()
			


	# mixin authorization methods
	_.extend Controller.prototype, Authorization

	Controller
