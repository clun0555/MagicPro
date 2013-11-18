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

		events: 
			"click [data-user]": "showUser"

		initialize: ->
			@collection = App.request "users:all"
			@listenTo @collection, "reset", @render, this


		showUser: (event) ->

			id = $(event.currentTarget).data("user")
			App.execute "admin:controller", "edit:user", id


			# App.vent.trigger "usernavigator:user:clicked", email
			# App.showModal new UserEditView(model: user)
			# alert user.get("username")



