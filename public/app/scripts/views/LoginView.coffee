define [
	"underscore"
	"Base"
	"App"
	"templates/login"

], (_, Base, App, template) -> 
	
	class LoginView extends Base.ItemView
		template: template
		className: "login-view"
		events:
			'click .login-button': "login"

		initialize: ->
			@model = new Base.Model()

		login: ->
			@model.set
				username: @$("[name=username]").val()
				password: @$("[name=password]").val()
			
			@hideErrorMessage()
			if @errorMessage()?
				return @showErrorMessage @errorMessage()

			@disableButtons()

			App.request("user:login", @model.attributes)
				.fail =>
					@enableButtons()
					@showErrorMessage("login.password-mail-incorrect")

		showErrorMessage: (message) ->
			@$(".alert").html(message).slideDown()

		hideErrorMessage: ->
			@$(".alert").slideUp()

		disableButtons: ->
			@$(".btn").attr "disabled", "disabled"

		enableButtons: ->
			@$(".btn").attr "disabled", null

		errorMessage: ->
			switch 
				when @model.get("username") is "" then "login.email-isempty"
				when @model.get("password") is "" then "login.password-isempty"
							

					
