define [

	"Base"
	"App"
	"templates/footer"

], (Base, App, template) ->

	class Footer extends Base.ItemView

		className: "footer-view"
		template: template

		events: 
			"click [data-locale]": "changeLocale"

		initialize: ->
			@model = new Base.Model()
			@model.set "locales", App.request("translator:locales:list")
			@model.set "currentLocal", App.request("translator:locales:current")

		changeLocale: (event) ->
			locale = $(event.currentTarget).data("locale")
			App.request("translator:locale:change", locale).done =>
				@model.set "currentLocal", App.request("translator:locales:current")				