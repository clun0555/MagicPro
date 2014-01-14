define [
	"jquery"
	"./directives"
], ($, directives) ->

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

	loadImage = (contexts, image, resizeOptions, element, $scope) ->

		contexts.current.canvas.attr
			width: resizeOptions.width
			height: resizeOptions.height

		contexts.current.context.drawImage.apply contexts.current.context, drawOptions(image, resizeOptions) 
		
		if contexts.current.canvas.height() > contexts.other().canvas.height()
			contexts.switch()
			setTimeout ->
				$scope.resize()
			, 300
			
		else
			$scope.resize()
			setTimeout ->
				contexts.switch()
			, 300
		


	directives.directive "imtThumbPreview", ($fileUploader, $window, ImageSizeService) ->
		restrict: "A"
		template: "<canvas class=\"first-canvas\" /><canvas class=\"second-canvas\" />"
		
		link: (scope, element, attributes) ->

			# 2 canvas/contexs are created to allow a smooth transition when changing images
			contexts =
				first: 
					canvas: element.find(".first-canvas")					
				second:
					canvas: element.find(".second-canvas")									
			
			contexts.first.context = contexts.first.canvas[0].getContext("2d")
			contexts.second.context = contexts.second.canvas[0].getContext("2d")

			contexts.current = contexts.first
			contexts.other = -> if @first is @current then @second else @first
			contexts.hide = -> $(@other().canvas).fadeOut()
			contexts.switch = -> 
				$(@current.canvas).fadeIn()
				$(@other().canvas).fadeOut()
				@current = @other()
			
			contexts.first.context.scale(window.devicePixelRatio, window.devicePixelRatio)
			contexts.second.context.scale(window.devicePixelRatio, window.devicePixelRatio)

			handleFileChange = ->
				# when file changes, change preview
				resizeOptions = ImageSizeService.getResizeInput(attributes.imtThumbPreview, scope.fileItem.dim)
				loadImage contexts, scope.fileItem.image, resizeOptions, element, scope
			
			handleFileRemove = ->	
				# hide canvas when remove image
				contexts.hide() unless scope.fileItem?.image?
					

			scope.$watch 'currentImage', handleFileChange
			scope.$watch 'fileItem', handleFileRemove
				
			
				



	
			
			
	