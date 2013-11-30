define [
	"Base"
	"App"
	"templates/bread_crumb"
], (Base, App, template) ->
	
	class BreadCrumbView extends Base.ItemView
		template: template
		tagName: "ol"

		className: 'breadcrumb bread-crumb-view'

		modelEvents:
			"change": "render"

		events: ->
			'click .breadcrumb-home': "showHome"
			'click .breadcrumb-category': "showTypes"
			'click .breadcrumb-type': "showProducts"

		showHome: ->
			App.navigate "product:show:categories"			

		showTypes: ->
			App.navigate "product:show:types", [ @model.get("category").slug ]			

		showProducts: ->
			App.navigate "product:show:products", [ @model.get("category").slug, @model.get("type").slug ]			