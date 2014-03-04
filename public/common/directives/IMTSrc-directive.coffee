define [
	"underscore"
	"jquery"
	"./directives"
	"common/utils/Environment"
], (_, $, directives, Environment) ->

	path = Environment.IMAGE_SERVER_PATH



	directives.directive "imtSrc", (ImageSizeService) ->
		{
			restrict: "A"
			template: 
				"""
					<div  class="imt-image-placeholder">
						<img 
							ng-src="{{imageSrc}}"
							title="{{imageTitle}}"														
						/>
					</div>
				"""
				# can help debug image size breakpoints
				# <h2 style="position:absolute; top: 0; left: 0;margin-left: 50px" >{{sizeInfo.width}}</h2>
				
			scope: true
			# replace: true
			controller: ($element, $scope, $attrs) ->
				resize = ->
					elementWidth = $element.width()
					if elementWidth isnt $scope.elementWidth
						$scope.elementWidth = elementWidth
						image = $scope.$eval($attrs.imtSrc)
						if image
							$scope.size = $attrs.imtSize
							sizeInfo = ImageSizeService.optimized(ImageSizeService.getResizeInput($scope.size, image), elementWidth)
							
							if $scope.sizeInfo?.width isnt sizeInfo.width
								# console.log "new size " + elementWidth + "/" + sizeInfo.width
								$scope.sizeInfo = sizeInfo 
								imageQuery = ImageSizeService.generateResizeQuery(sizeInfo)
								$scope.imageSrc = "#{path}/#{ image.path ? 'placeholder2.jpg' }?#{imageQuery}"
								$scope.$$phase || $scope.$apply()

				throttledResize = _.throttle(resize, 100)

				$(window).bind "resize", throttledResize

				$scope.$on '$destroy', ->
					# cleanup to avoid memory leaks
					$(window).unbind "resize", throttledResize	

				resize()




			link: (scope, element, attrs) ->
				$(element).addClass "imt-image-wrapper"
				image = scope.$eval(attrs.imtSrc)
				scope.size = attrs.imtSize
				scope.imageTitle = image.name ? ''

				if image?
					sizeInfo = ImageSizeService.getResizeInput(scope.size, image)
					

					# $(element).css {
					# 	'max-width': sizeInfo.width
					# 	'max-height': sizeInfo.height						
					# }

					$(element).find('.imt-image-placeholder').css {
						'padding-top': ((sizeInfo.height/sizeInfo.width) * 100) + "%"
						# 'max-width': sizeInfo.width + "px"
						# 'max-height': sizeInfo.height + "px"
					}	

					$(element).find("img").bind "load", ->
						this.style.opacity='1'
						$(this).parent().addClass('loaded')
						# alert image.path					


							
	
		}
