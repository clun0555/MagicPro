define [
	"./directives"
	"jquery"
	"underscore"
], (directives, $, _) ->


	directives.directive 'imtScrollSpy', ($window) ->
		restrict: 'A'
		
		controller: ($scope) ->
			$scope.spies = []
			@addSpy = (spyObj) -> $scope.spies.push spyObj
			return
		
		link: (scope, elem, attrs) ->
			
			
			# scope.$watch 'spies', (spies) ->
			# 	for spy in spies
			# 		unless spyElems[spy.id]?
			# 			spyElems[spy.id] = elem.find('#'+spy.id)
			# , true


	 
			scrollHandler = ->
				spyElems = []
				highlightSpy = null
				for spy in scope.spies
					spy.out()
	 
					# the elem might not have been available when it was originally cached,
					# so we check again to get another element in case this one doesn't exist.
					spyElems[spy.id] = elem.find('#'+spy.id)
						# if spyElems[spy.id].length is 0
							
						# else
						# 	spyElems[spy.id]
	 
					# the element could still not exist, so we check first to avoid errors
					if spyElems[spy.id].length isnt 0
						if (pos = spyElems[spy.id].offset().top) - $window.scrollY <= 0
							spy.pos = pos
							highlightSpy ?= spy
							if highlightSpy.pos < spy.pos
								highlightSpy = spy

						if (pos = spyElems[spy.id].offset().top) - $window.scrollY <= 300
							spy.start()
							spy.pos = pos
							highlightSpy ?= spy
							if highlightSpy.pos < spy.pos
								highlightSpy = spy
	 
				highlightSpy?.in()

			windowEl = angular.element($window)
			windowEl.on 'scroll', scrollHandler
			# windowEl.on 'touchmove', _.throttle(scrollHandler, 100)