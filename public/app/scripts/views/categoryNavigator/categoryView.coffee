define [
	"Base"
	"templates/categoryNavigator/category"
], (Base, template) ->

	class CategoryView extends Base.ItemView
		template: template
		className: 'category-view col-md-3'
