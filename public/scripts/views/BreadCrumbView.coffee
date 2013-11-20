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
			'click .breadcrumb-home': "navigateHome"
			'click .breadcrumb-category': "navigateCategory"
			# 'click .breadcrumb-type': "navigateType"

		navigateHome: ->
			App.execute "product:finder:controller", "navigate:home"			

		navigateCategory: ->
			App.execute "product:finder:controller", "navigate:category"