define [
	"Base"
	"App"
	"views/categorynavigator/CategoryView"
], (Base, App, CategoryView) ->

	class CategoryNavigator extends Base.CollectionView

		itemView: CategoryView
		tagName: 'div'
		className: 'category-navigator thumnails'	
