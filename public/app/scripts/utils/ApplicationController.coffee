define [
	"App"
	"views/LoginView"
	"views/RegisterView"
	"views/ProductNavigator"
], (App, LoginView, RegisterView, ProductNavigator) ->

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
		App.mainRegion.show new ProductNavigator()

	loggedIn: ->
		logged = App.request("user")?
		@login() unless logged			
		logged

