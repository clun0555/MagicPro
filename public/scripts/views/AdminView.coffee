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

		onRender: ->
			@sidebarRegion.show new AdminSidebarView()

		showUser: (user) ->
			@mainRegion.show new UserEditView model: user

		createUser: ->
			@mainRegion.show new UserEditView(model: new User(role: "user"))

		showUserNavigator: (users) ->
			@mainRegion.show new UserNavigatorView collection: users
			
		

