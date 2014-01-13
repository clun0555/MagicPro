define [
	"./directives"
], (directives) ->

	drawOptions = (image, resizeOptions) ->
		switch resizeOptions.action
			when "square"
				if image.height >= image.width
					[ image, 0, 0, image.width, image.width, 0, 0, resizeOptions.width, resizeOptions.height ]
				else
					[ image, 0, 0, image.height, image.height, 0, 0, resizeOptions.width, resizeOptions.height ]

			when "resize"
				[ image, 0, 0, resizeOptions.width, resizeOptions.height ]

			when "crop"
				# todo handle crop
				[ image, 0, 0, image.width, image.width, 0, 0, width, height ]

	loadImage = (context, canvas, image, resizeOptions) ->
				
		canvas.attr
			width: resizeOptions.width
			height: resizeOptions.height

		context.drawImage.apply context, drawOptions(image, resizeOptions) 


	directives.directive "imtThumbPreview", ($fileUploader, $window, ImageSizeService) ->
		restrict: "A"
		template: "<canvas/>"
		
		link: (scope, element, attributes) ->

			canvas = element.find("canvas")
			context = canvas[0].getContext("2d")
			context.scale(window.devicePixelRatio, window.devicePixelRatio)

			scope.$watch 'fileItem', -> 
				# when file changes, change preview
				if scope.fileItem?.image?
					resizeOptions = ImageSizeService.getResizeInput(attributes.imtThumbPreview, scope.fileItem.dim)
					loadImage context, canvas, scope.fileItem.image, resizeOptions

			
			
			
			
	