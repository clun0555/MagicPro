define [
	"App"
	"Base"
	"templates/usernavigator/user_title"
], (App, Base, template) ->

	class UserTitleView extends Base.ItemView
		template: template		
		className: 'user-title col-md-3'
		tagName: "li"

		events:
			"click": -> App.navigate "admin:user:edit", [ @model.get("_id") ]

		onRender: ->
			@$el.attr "data-user", @model.get("_id")
