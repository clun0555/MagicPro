define [

	"Base"
	"App"
	"views/orderHeader/OrderMenuItem"
	"templates/orderHeader/orderMenu"

], (Base, App, OrderMenuItem, template ) ->

	class OrderMenu extends Base.CompositeView

		itemView: OrderMenuItem
		className: "order-menu container"
		itemViewContainer: 'ul'
		template: template

		initialize: ->
			@listenTo @collection, "change", @render, this