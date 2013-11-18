define [
	"Base"
	"App"
	"utils/Authorization"	
	"views/AdminView"
], (Base, App, Authorization, AdminView) ->

	class AdminController extends Base.Controller
		
		routes: 
			"admin": "showAdmin"
			"admin/users": "showUsers"
			"admin/users/new": "createUser"
			"admin/users/:id": "editUser"

		authorize: (action) -> 	@isAdmin()

		showAdminView: ->			
			@show new AdminView() unless App.mainRegion instanceof AdminView				

		showUsers: -> @showAdminView()

		showAdmin: -> @showUsers()

		createUser: ->
			@showAdminView()
			@region.currentView.createUser()

		editUser: (id) ->
			@showAdminView()
			@region.currentView.showUser id