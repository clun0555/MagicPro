define [
	"./directives"
], (directives) ->



	directives.directive "imtThumbPreview", ["$fileUploader", "$window", ($fileUploader, $window) ->
		restrict: "A"
		template: "<canvas/>"
		link: (scope, element, attributes) ->
			pixelRatio = window.devicePixelRatio

	
			# not $fileUploader.isHTML5 or 
			return  if not $window.FileReader or not $window.CanvasRenderingContext2D
			params = scope.$eval(attributes.imtThumbPreview)
			return  if not angular.isObject(params.file) or (params.file not instanceof $window.File)
			type = params.file.type
			type = "|" + type.slice(type.lastIndexOf("/") + 1) + "|"
			return  if "|jpg|png|jpeg|bmp|".indexOf(type) is -1


			canvas = element.find("canvas")
			context = canvas[0].getContext("2d")
			context.scale(pixelRatio, pixelRatio)

			if params.width? and params.height?
				canvas.attr
					width: params.width
					height: params.height


			onLoadFile = (event) ->
				img = new Image()
				img.onload = onLoadImage
				img.src = event.target.result
			
			onLoadImage = ->
				width = params.width or @width / @height * params.height
				height = params.height or @height / @width * params.width
				canvas.attr
					width: width
					height: height

				if params.crop?

					if @height >= @width
						context.drawImage this, 0, 0, @width, @width, 0, 0, width, height
					else
						context.drawImage this, 0, 0, @height, @height, 0, 0, width, height

				else				
					context.drawImage this, 0, 0, width, height			
			
			
			reader = new FileReader()
			reader.onload = onLoadFile
			reader.readAsDataURL params.file
	]