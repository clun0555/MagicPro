define [
	"Base"
	"templates/admin_sidebar"
], (Base, template) ->
	
	class AdminSidebar extends Base.ItemView
		template: template

		className: 'admin-sidebar list-group'