define [
	"./directives"
	"common/utils/Environment"
], (directives, Environment) ->

	path = Environment.IMAGE_SERVER_PATH

	# this directive is deprecated, please use imtSrc
	directives.directive "imtImage", () ->
		{
			restrict: "A"
			template:
				"""
					<div class="imt-responsive-image" >
						<img
							ng-src="#{path}/{{image.path}}?{{size}}"
						/>
					</div>
				"""
			scope: true
			# replace: true
			link: (scope, element, attrs) ->
				scope.image = scope.$eval(attrs.imtImage)
				scope.size = attrs.imtSize
				scope.$watchCollection attrs.imtImage, ->
					scope.image = scope.$eval(attrs.imtImage)
		}
