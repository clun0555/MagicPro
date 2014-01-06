define [
	"./directives"
], (directives) ->

	directives.directive "imtImage", () ->
		{
			restrict: "E"
			template: "<img  ng-src=\"http://image-resizer-magicpro.herokuapp.com/{{ src || 'placeholder2.jpg'}}?{{size}}\" />"
			require: '^ngSrc'
			scope:
				src: '@'
				size: '@'
				class: '@'
			# replace: true			
						
		}
