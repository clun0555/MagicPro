###
	Define here all helper methods to mixin in all views prototype
###


define [
	"underscore"
	"utils/Translator"
], (_, Translator) ->
	
	ViewHelpers = {}


	# mixin Translator functions
	_.extend ViewHelpers, Translator

	ViewHelpers
