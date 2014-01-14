define [
	"./directives"
], (directives) ->

	# this directive is deprecated, please use imtSrc
	directives.directive "imtImage", () ->
		{
			restrict: "E"
			template: "<img class=\"imt-image\" onload=\"this.style.opacity='1'\" ng-src=\"http://image-resizer-magicpro.herokuapp.com/{{ src || 'placeholder2.jpg'}}?{{size}}\" />"
			require: '^ngSrc'
			scope: 
				src: '@'
				size: '@'
				class: '@'
			# replace: true			
						
		}
