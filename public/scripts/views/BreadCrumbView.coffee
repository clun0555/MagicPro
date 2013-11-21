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
			'click .breadcrumb-category': "showCategory"
			'click .breadcrumb-type': "showType"

		showHome: ->
			App.execute "product:finder:controller", "show:home"			

		showCategory: ->
			App.execute "product:finder:controller", "show:category"

		showType: ->
			App.execute "product:finder:controller", "show:type"