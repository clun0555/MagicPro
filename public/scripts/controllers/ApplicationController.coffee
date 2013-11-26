define [
	"Base"
	"App"
	"utils/Authorization"
	"views/LoginView"
	"views/RegisterView"
	"views/ErrorPageView"
	"views/AdminView"

], (Base, App, Authorization, LoginView, RegisterView, ErrorPageView, AdminView) ->

	class ApplicationController extends Base.Controller2
		
		states:
			"app:root": "root"
			"app:show:error:page": "showErrorPage"
			"app:login": "login"
			"app:register": "register"

		root: -> 
			App.navigate "product:show:categories", [], { history: false }

		login: (forward) ->
			options = if forward then { forward: forward } else {}
			@show new LoginView options

		register: ->
			@show new RegisterView()

		show404ErrorPage: ->
			@showErrorPage 404

		showErrorPage: (code) ->
			@show new ErrorPageView(model: new Base.Model(code: code))		



				