define [
	"jquery"
	"./directives"
	"common/utils/Environment"
], ($, directives, Environment) ->

	path = Environment.IMAGE_SERVER_PATH

	directives.directive "imtSrc", (ImageSizeService) ->
		{
			restrict: "A"
			template: 
				"""
					<div class="imt-image-wrapper" >
						<img 
							onload="this.style.opacity='1'"
							class="imt-image img-responsive"
							ng-src="{{imageSrc}}"														
						/>
					</div>
				"""
			scope: true
			replace: true
			link: (scope, element, attrs) ->
				image = scope.$eval(attrs.imtSrc)
				scope.size = attrs.imtSize

				if image?
					sizeInfo = ImageSizeService.getResizeInput(scope.size, image)
					scope.imageSrc = "#{path}/#{ image.path ? 'placeholder2.jpg' }?#{scope.size}"

					# $(element).css {
					# 	width: sizeInfo.width
					# 	height: sizeInfo.height						
					# }

					# $(element).find('img').css {
					# 	width: sizeInfo.width
					# 	height: sizeInfo.height						
					# }
	
		}
