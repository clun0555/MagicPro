define [
	"Base"
	"App"
	"utils/Authorization"
	"views/LoginView"
	"views/RegisterView"
	"views/ErrorPageView"
	"views/AdminView"

], (Base, App, Authorization, LoginView, RegisterView, ErrorPageView, AdminView) ->

	class ApplicationController extends Base.Controller
		
		routes: 
			"" : "root"
			"login": "login" 
			"register": "register" 
			"*path" : "show404ErrorPage"

		root: -> 
			App.execute "product:finder:controller", "show:navigator", [], { history: false }

		login: (forward) ->
			options = if forward then { forward: forward } else {}
			@show new LoginView options

		register: ->
			@show new RegisterView()

		show404ErrorPage: ->
			@showErrorPage 404

		showErrorPage: (code) ->
			@show new ErrorPageView(model: new Base.Model(code: code))


				