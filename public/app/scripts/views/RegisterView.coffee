define [

	"Base"
	"App"
	"templates/register"

], (Base, App, template) -> 
	
	class RegisterView extends Base.ItemView
		template: template

		className: "register-view"

		events:
			'click .register-button': "register"

		register: ->
			
			user = 
				firstname: @$("[name=firstname]").val()
				lastname: @$("[name=lastname]").val()
				username: @$("[name=email]").val()
				password: @$("[name=password]").val()


			App.request("user:register", user)
				.done ->
					App.vent.trigger "user:loggedin"
				.fail =>
					@showErrorMessage "Oops... Wrong data"

		showErrorMessage: (message) ->
			@$(".alert").html(message).slideDown()

		hideErrorMessage: ->
			@$(".alert").slideUp()

		disableButtons: ->
			@$(".btn").attr "disabled", "disabled"

		enableButtons: ->
			@$(".btn").attr "disabled", null