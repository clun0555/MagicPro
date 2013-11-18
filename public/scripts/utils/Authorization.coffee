define [
	"App"
], (App) ->
	
	is: (role) -> 
		user = App.request("user")
		if user? then user.is role else false
	
	isAdmin: -> 
		user = App.request("user")
		if user? then user.isAdmin() else false

	isLoggedIn: ->
		return App.request("user")?

