###
	Define here all helper methods to mixin in template context
###


define [
	"underscore"
	"utils/Translator"
], (_, Translator) ->
	
	TemplateHelpers = {}

	# mixin Translator functions
	_.extend TemplateHelpers, Translator

	TemplateHelpers


