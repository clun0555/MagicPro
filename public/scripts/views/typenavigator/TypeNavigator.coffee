define [

	"Base"
	"App"
	"views/typenavigator/TypeView"

], (Base, App, TypeView) ->

	class TypeNavigator extends Base.CollectionView

		itemView: TypeView
		tagName: 'div'
		className: 'type-navigator thumnails'
		

