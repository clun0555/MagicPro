define [

	"Base"
	"App"
	"views/usernavigator/UserTitleView"
	"views/usernavigator/UserEditView"

], (Base, App, UserTitleView, UserEditView) ->
	
	class UserNavigatorView extends Base.CollectionView
		
		itemView: UserTitleView
		tagName: 'div'
		className: 'user-navigator'



