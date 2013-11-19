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


		initialize: ->
			@model = App.state.productFinder
						
		navigateHome: ->
			App.state.productFinder.set "category": null, "type": null
			# App.state.productFinder.unset 

		navigateCategory: ->
			App.state.productFinder.unset "type"