###
	Define here all helper methods to mixin in all views prototype
###


define [
	"underscore"
	"utils/Translator"
	"utils/Authorization"
], (_, Translator, Authorization) ->
	
	ViewHelpers = {}

	# mixin Translator functions
	_.extend ViewHelpers, Translator
	_.extend ViewHelpers, Authorization

	ViewHelpers
