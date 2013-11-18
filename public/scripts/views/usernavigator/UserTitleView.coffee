define [
	"Base"
	"templates/usernavigator/user_title"
], (Base, template) ->

	class UserTitleView extends Base.ItemView
		template: template		
		className: 'user-title col-md-3'
		tagName: "li"

		# event:
		# 	"click": -> @trigger 

		onRender: ->
			@$el.attr "data-user", @model.get("_id")
