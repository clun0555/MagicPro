define [
	"Base"
	"App"
	"models/User"
	"views/AdminSidebarView"
	"views/UserNavigatorView"
	"views/usernavigator/UserEditView"
	"templates/admin"
], (Base, App, User, AdminSidebarView, UserNavigatorView, UserEditView, template) ->
	
	class AdminView extends Base.Layout
		
		template: template

		className: "admin"

		regions: 
			"sidebarRegion": ".sidebar-region"
			"mainRegion": ".main-region"

		showUser: (id) ->
			App.state.user = App.request "users:get", id
			@mainRegion.show new UserEditView(model: App.state.user)

		createUser: ->
			@mainRegion.show new UserEditView(model: new User(role: "user"))

		showUserNavigator: ->
			App.state.user = null
			@mainRegion.show new UserNavigatorView()

		onRender: ->
			@sidebarRegion.show new AdminSidebarView()
			@showUserNavigator()

