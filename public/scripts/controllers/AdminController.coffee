define [
	"Base"
	"App"
	"utils/Authorization"	
	"views/AdminView"
], (Base, App, Authorization, AdminView) ->

	class AdminController extends Base.Controller
		
		states: 
			"admin:show": "showAdminView"
			"admin:user:index": "showUsers"
			"admin:user:create": "createUser"
			"admin:user:edit": "editUser"

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