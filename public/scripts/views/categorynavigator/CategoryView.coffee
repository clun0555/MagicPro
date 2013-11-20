define [
	"App"
	"Base"
	"templates/categorynavigator/category"
], (App, Base, template) ->

	class CategoryView extends Base.ItemView
		template: template
		className: 'category-view col-md-3'

		events: 
			'click': "selectCategory"

		selectCategory: ->
			App.execute "product:finder:controller", "show:navigator", [ @model.get("_id") ]
