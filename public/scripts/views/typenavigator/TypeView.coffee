define [
	"Base"
	"App"
	"templates/typenavigator/type"
], (Base, App, template) ->

	class TypeView extends Base.ItemView
		template: template
		className: 'type-view col-md-3'

		events: 
			"click": "selectType"

		selectType: ->
			App.state.productFinder.set "type", @model.toJSON()

