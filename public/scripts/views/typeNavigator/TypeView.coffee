define [
	"Base"
	"templates/typeNavigator/type"
], (Base, template) ->

	class TypeView extends Base.ItemView
		template: template
		className: 'type-view col-md-3'
