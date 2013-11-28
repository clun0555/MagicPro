define [
	"Base"
	"App"
	"utils/Authorization"	
	"views/AdminView"
], (Base, App, Authorization, AdminView) ->

	class AdminController extends Base.Controller
		
		states: 
			"admin:show": "showAdmin"
			"admin:user:index": "showUsers"
			"admin:user:create": "createUser"
			"admin:user:edit": "editUser"

		authorize: (action) -> 	@isAdmin()

		showAdminView: ->			
			@show new AdminView() unless App.mainRegion instanceof AdminView			

		showAdmin: ->
			App.navigate "admin:user:index", [], { history: false }

		showUsers: -> 
			@do [
				App.request("users:all")
			], (users) =>
				@showAdminView()
				@region.currentView.showUserNavigator users

		createUser: ->
			@showAdminView()
			@region.currentView.createUser()

		editUser: (id) ->
			@do [
				App.request("users:get", id)
			], (user) =>
				@showAdminView()
				@region.currentView.showUser user