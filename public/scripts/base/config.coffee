define [
	"underscore"
	"underscore.string"
	"marionette"
	"base/utils/TemplateHelpers"

], (_, _str, Marionette, TemplateHelpers) ->

	# use compiled templates by default
	Marionette.Renderer.render = (template, data) ->
		data = _.extend data, TemplateHelpers
		template data

	# mixin underscore.string into underscore.js namespace
	_.mixin _str.exports()

