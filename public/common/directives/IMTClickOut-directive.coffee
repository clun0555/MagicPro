define [
	"./directives"
], (directives) ->

	bound = false

	directives.directive "imtClickOut", ($document) ->
		restrict: "A"
		scope: true
		
		link: (scope, elem, attr, ctrl) ->
			elem.bind "click", (e) ->
				
				# this part keeps it from firing the click on the document.
				e.stopPropagation()





			$document.bind "click", ->
				
				# magic here.
				scope.$apply attr.imtClickOut

				return true