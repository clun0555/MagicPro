define [
	"underscore"
	"./translation-common"

	# reference all translations here
	"./translation-en"
	"./translation-cn"

], (_, common) ->

	# Manipulate translations here to extend file structure (ex: allow nesting....)
	
	for translation in arguments when translation not in [common, _]
		# adds common translations to all translations
		_.extend translation, common 