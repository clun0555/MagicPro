define [
	"underscore"
	"../contact-states"	
], (_, contact) ->

	contact.controller "ContactController", ($scope) ->		

		$scope.message = {}

		# $scope.submiting = false

		$scope.send = ->
			$scope.errors = {}
			$scope.submited = true
			
			if $scope.data.$valid

				$scope.submiting = true
				console.log $scope.message
				alert "comming soon..."

		
		