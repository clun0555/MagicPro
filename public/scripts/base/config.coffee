define [
	"underscore"
	"marionette"
	"base/utils/TemplateHelpers"

], (_, Marionette, TemplateHelpers) ->

	# use compiled templates by default
	Marionette.Renderer.render = (template, data) ->
		data = _.extend data, TemplateHelpers
		template data

