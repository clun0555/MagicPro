define [
	"./directives"
], (directives) ->

	directives.directive 'imtServerError', ->
	  
		restrict: 'A'
		require: '?ngModel'
		link: (scope, element, attrs, ctrl) ->
			element.on 'keyup', ->
				scope.$apply ->
					ctrl.$setValidity('server', true)
	  