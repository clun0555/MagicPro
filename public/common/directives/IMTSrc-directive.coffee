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
						<div  class="imt-image-placeholder">
							<img 
								onload="this.style.opacity='1'"
								ng-src="{{imageSrc}}"														
							/>
						</div>						
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

					$(element).css {
						'max-width': sizeInfo.width
						'max-height': sizeInfo.height						
					}

					$(element).find('.imt-image-placeholder').css {
						'padding-top': ((sizeInfo.height/sizeInfo.width) * 100) + "%"
						'max-width': sizeInfo.width + "px"
						'max-height': sizeInfo.height + "px"
					}
	
		}
