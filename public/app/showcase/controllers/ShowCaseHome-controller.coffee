define [
	"underscore"
	"../showcase-states"	
], (_, showcase) ->

	showcase.controller "ShowCaseHomeController", ($scope, $timeout) ->		

		$scope.$on '$viewContentLoaded', -> 
			$timeout ->
				$scope.loaded = true
			, 500
			

		$scope.currentSlide = 1


		$scope.previousSlide = ->
			$scope.currentSlide -= 1	

		$scope.nextSlide = ->
			$scope.currentSlide += 1			

				

		
		