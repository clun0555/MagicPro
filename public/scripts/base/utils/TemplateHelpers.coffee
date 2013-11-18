###
	Define here all helper methods to mixin in template context
###


define [
	"underscore"
	"utils/Translator"
	"utils/Authorization"
	"utils/ImageProxy"
], (_, Translator, Authorization, ImageProxy) ->
	
	TemplateHelpers = {}

	# mixin Translator functions
	_.extend TemplateHelpers, Translator
	_.extend TemplateHelpers, Authorization
	_.extend TemplateHelpers, ImageProxy

	TemplateHelpers


