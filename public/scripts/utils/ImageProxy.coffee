define [
	"utils/Environment"
], (Environment) ->

	imagePath: (imageId, format) ->
		return Environment.IMAGE_SERVER_PATH + "/#{imageId}?#{format}"