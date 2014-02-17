define [
	"./directives"
], (directives) ->

	directives.directive "imtScrollPosition", ($window) ->
		{
					
			scope:
				scroll: '=imtScrollPosition'

			link: (scope, element, attrs) ->
				windowEl = angular.element($window)
				scope.scroll = 10
				handler = ->
					scope.scroll = windowEl.scrollTop()
				
				windowEl.on 'scroll', scope.$apply.bind(scope, handler)
				windowEl.on 'touchmove', scope.$apply.bind(scope, handler)
				
				handler()
			
						
		}
