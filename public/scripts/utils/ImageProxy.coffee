define [
	"utils/Environment"
], (Environment) ->

	imagePath: (imageId = "placeholder2.jpg", format) ->

		return Environment.IMAGE_SERVER_PATH + "/#{imageId}?#{format}"