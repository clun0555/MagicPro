define [
	"Base"
	"App"
	"utils/Authorization"
	"views/LoginView"
	"views/RegisterView"
	"views/OrderLayout"
	"views/ErrorPageView"
	"views/AdminView"

], (Base, App, Authorization, LoginView, RegisterView, OrderLayout, ErrorPageView, AdminView) ->

	class ApplicationController extends Base.Controller
		
		routes: 
			"" : "root"
			"login": "login" 
			"register": "register" 
			"products": "products"			
			"*path" : "show404ErrorPage"

		authorize: (action) -> 
			
			# products action is restricted to logged in users
			return @isLoggedIn() if action is "products" 				

			return true

		root: -> @run "products"

		login: (forward) ->
			console.log "login"
			options = if forward then { forward: forward } else {}
			@show new LoginView options

		register: ->
			@show new RegisterView()

		products: ->
			@show new OrderLayout()	

		show404ErrorPage: ->
			@showErrorPage 404

		showErrorPage: (code) ->
			@show new ErrorPageView(model: new Base.Model(code: code))


				