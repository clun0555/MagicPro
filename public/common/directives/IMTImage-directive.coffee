define [
	"./directives"
	"common/utils/Environment"
], (directives, Environment) ->

	path = Environment.IMAGE_SERVER_PATH

	# this directive is deprecated, please use imtSrc
	directives.directive "imtImage", () ->
		{
			restrict: "E"
			template: "<img class=\"imt-image\" onload=\"this.style.opacity='1'\" ng-src=\"#{path}/{{ src || 'placeholder2.jpg'}}?{{size}}\" />"
			require: '^ngSrc'
			scope: 
				src: '@'
				size: '@'
				class: '@'
			# replace: true			
						
		}
