define [
	"underscore"
	"../showcase-states"	
], (_, showcase) ->

	showcase.controller "ShowCaseHomeController", ($scope, $timeout) ->		

		$scope.$on '$viewContentLoaded', -> 
			$timeout ->
				$scope.loaded = true
			, 500
			

				

		
		