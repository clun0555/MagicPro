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
			App.navigate "product:show:types", [ @model.id ]
