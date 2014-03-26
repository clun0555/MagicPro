define [
	"./directives"
	"jquery"
], (directives, $) ->


	directives.directive 'imtSpy', ($location, $rootScope) ->
		restrict: "A"
		require: "^imtScrollSpy"
		link: (scope, elem, attrs, imtScrollSpy) ->
			attrs.spyClass ?= "current"
			# $rootScope.startedSpys = {}
	 
			# elem.click ->
			# 	scope.$apply ->
			# 		$location.hash(attrs.imtSpy)
	 
			imtScrollSpy.addSpy
				id: attrs.imtSpy
				in: -> 
					elem.addClass attrs.spyClass
					$rootScope.currentSpy = attrs.imtSpy
				out: -> 
					elem.removeClass attrs.spyClass
					$rootScope.currentSpy = null

				start: ->
					$('body').addClass 'spy-' + attrs.imtSpy
					# $rootScope.startedSpys[] = true