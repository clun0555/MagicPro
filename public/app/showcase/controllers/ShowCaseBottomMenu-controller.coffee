define [
	"underscore"
	"../showcase-states"	
], (_, showcase) ->

	showcase.controller "ShowCaseBottomMenuController", ($scope, $timeout) ->	

		$scope.toggled = false

		$scope.toggleMenu = (menu) ->
			$scope.toggled = menu

		$scope.fold = ->
			$scope.toggled = false


		$scope.send = ->
			$scope.sent = true
		

				

		
		