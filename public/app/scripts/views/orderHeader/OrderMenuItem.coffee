define [
	"Base"
	"App"
	"templates/orderHeader/orderMenuItem"
], (Base, App, template) ->

	class OrderMenuItem extends Base.ItemView
		className: "category-menu"
		tagName: "li"
		template: template