define [
	"App"
	"Base"
	"templates/categoryNavigator/category"
], (App, Base, template) ->

	class CategoryView extends Base.ItemView
		template: template
		className: 'category-view col-md-3'

		events: 
			'click': "selectCategory"

		selectCategory: ->
			App.state.productFinder.set "category", @model.toJSON()
