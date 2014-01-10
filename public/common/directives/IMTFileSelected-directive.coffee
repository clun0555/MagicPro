define [
	"./directives"
], (directives) ->

	directives.directive "imtFileSelected", ($document) ->
		restrict: "A"
		link: (scope, elem, attr, ctrl) ->
			
			elem.bind 'change', (event) ->
				scope.$files = @files
				scope.$eval(attr.imtFileSelected)	