define [
	"underscore"
	"../contact-states"	
], (_, contact) ->

	contact.controller "ContactController", ($scope, MessageService) ->		

		$scope.message = {}		

		# $scope.submiting = false

		$scope.send = ->
			$scope.errors = {}
			$scope.submited = true
			
			if $scope.data.$valid

				$scope.submiting = true
				console.log $scope.message
				MessageService.send($scope.message).then ->
					$scope.sent = true

				

		
		