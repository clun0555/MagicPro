define [

	"Base"
	"App"
	"templates/orderMenu"

], (Base, App, template) ->

	class OrderMenu extends Base.ItemView

		className: "order-menu container"
		template: template
		navigationState: "category": null


		initialize: ->
			@render