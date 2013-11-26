define [

	"Base"
	"App"
	"templates/menu"

], (Base, App, template) ->

	class MenuView extends Base.ItemView

		className: "menu-view navbar navbar-inverse container"
		template: template

		events: 
			"click .logout-menu": "logout"
			"click .home-link": "navigateHome"
			"click .admin-link": "navigateAdmin"

		initialize: ->
			@listenTo App.vent, "user:loggedin", @render
			@listenTo App.vent, "user:loggedout", @render			

		serializeData: ->
			if App.user? then user: App.user.toJSON() else {}

		logout: ->
			App.request "user:logout"

		navigateHome: ->
			App.navigate "product:show:categories"

		navigateAdmin: ->
			App.navigate "admin:show"