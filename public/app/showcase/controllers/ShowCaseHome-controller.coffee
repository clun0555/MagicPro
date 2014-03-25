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
		$scope.motion = ""


		$scope.previousSlide = ->
			if $scope.motion == ""
				$scope.currentSlide -= 1
				$scope.currentSlide = 3 if $scope.currentSlide <1
				$scope.motion = "motion-left-" + $scope.currentSlide
				$timeout ->
					$scope.motion = ""
				, 500


		$scope.nextSlide = ->
			if $scope.motion == ""
				$scope.currentSlide += 1
				$scope.currentSlide = 1 if $scope.currentSlide >3
				$scope.motion = "motion-right-" + $scope.currentSlide
				$timeout ->
					$scope.motion = ""
				, 500

				

		
		