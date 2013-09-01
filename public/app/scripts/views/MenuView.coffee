define [

	"Base"
	"App"
	"templates/menu"

], (Base, App, template) ->

	class MenuView extends Base.ItemView

		className: "menu-view container"
		template: template

		events: 
			"click .logout-menu": "logout"

		initialize: ->
			@listenTo App.vent, "user:loggedin", @render
			@listenTo App.vent, "user:loggedout", @render

		serializeData: ->
			if App.user? then user: App.user.toJSON() else {}

		logout: ->
			App.request "user:logout"