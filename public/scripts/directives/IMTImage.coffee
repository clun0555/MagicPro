define [
	"./module"
], (directives) ->

	directives.directive "imtImage", () ->
		{
			restrict: "E"
			template: '<img class="{{class}}" src="http://image-resizer-magicpro.herokuapp.com/{{src}}?{{size}}" >'
			scope:
				src: '@'
				size: '@'
				class: '@'
						
		}
