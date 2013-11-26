define [
	"App"
	"jquery"
	"Base"
	"templates/usernavigator/user_edit"
	"bootstrap"
	"jquery-fileupload"
], (App, $, Base, template) ->

	class UserEditView extends Base.ItemView
		template: template		
		className: 'user-edit '


		modelEvents: 
			"sync": "render"
			"change:role": "render"
			"change:imageId": "render"
			# "change:role": "render"

		events: 
			'click [data-role]': "changeRole"
			'click .save-button': "save"
			'click .return-button': "goBack"
			'change .firstname': "changeFirstName"
			'change .lastname': "changeLastName"
			'change .email': "changeEmail"
		

		onRender: ->
			$('#fileupload').fileupload 
				url: "/file/create", 
				# dataType: 'json',
				done: (e, data) =>
					@model.set "imageId", data.result



		changeRole: (event) ->
			role = $(event.currentTarget).data("role")
			@model.set "role", role
		
		changeFirstName: (event) ->
			@model.set "firstname", $(event.currentTarget).val()

		changeLastName: (event) ->
			@model.set "lastname", $(event.currentTarget).val()

		changeEmail: (event) ->
			@model.set "email", $(event.currentTarget).val()

		goBack: ->
			App.navigate "admin:user:index"


		save: ->			
			@model.save {}, success: @goBack
		




