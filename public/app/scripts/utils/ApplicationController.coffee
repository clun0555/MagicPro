define [
	"App"
	"views/LoginView"
	"views/RegisterView"
	"views/OrderLayout"
], (App, LoginView, RegisterView, OrderLayout) ->

	root: ->
		return unless @loggedIn()
		@products()

	login: ->
		return @root() if App.request("user")?		
		App.mainRegion.show new LoginView()


	register: ->
		return @root() if App.request("user")?
		App.mainRegion.show new RegisterView()

	products: ->
		return unless @loggedIn()
		return if App.mainRegion.currentView instanceof OrderLayout
		App.mainRegion.show new OrderLayout()

	loggedIn: ->
		logged = App.request("user")?
		@login() unless logged			
		logged

