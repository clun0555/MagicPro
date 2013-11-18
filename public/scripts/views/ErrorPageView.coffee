define [

	"Base"
	"App"
	"templates/error_page"

], (Base, App, template) ->

	class ErrorPageView extends Base.ItemView

		className: "error-page"
		template: template

		