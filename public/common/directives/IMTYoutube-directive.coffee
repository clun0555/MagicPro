define [
	"jquery"
	"./directives"
], ($, directives) ->

	youtubeLinkParser = (url) ->
		regExp = /^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=|\?v=)([^#\&\?]*).*/
		match = url.match(regExp)
		if match and match[2].length is 11
			match[2]
		else
			null

	directives.directive "imtYoutube", ($sce) ->
		restrict: "EA"
		
		scope:
			imtYoutube: "="

		replace: true
		
		template: "<div ><iframe style=\"overflow:hidden;height:100%;width:100%\" width=\"100%\" height=\"100%\" ng-src=\"{{url}}\" frameborder=\"0\" allowfullscreen></iframe></div>"
		
		link: (scope, element, attrs) ->

			scope.$watch "imtYoutube", (newVal) ->
				
				scope.url = $sce.trustAsResourceUrl("http://www.youtube.com/embed/" + youtubeLinkParser(newVal))  if newVal
				return

			return
