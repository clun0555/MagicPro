define [
	"./controllers"
	"resources/translations/translations"
], (controllers, translations) ->
	
	controllers
		.controller "LoginController", ($scope, $state, SessionService, $parse) ->
			
			$scope.login = ->
				$scope.errors = {}
				$scope.submited = true

				if $scope.credentials.$valid

					SessionService.login($scope.email, $scope.password).then(
						
						->
							$state.go "shop.categories"
						->
							$scope.credentials["email"].$setValidity('server', false)
							$scope.errors["email"] = "Wrong password / login"
							# fieldName = "email"
							# serverMessage = $scope.credentials.$setValidity(fieldName, false, $scope.credentials)
							# $parse('credentials.'+fieldName+'.$error.serverMessage')							
							# serverMessage.assign($scope, "Wrong password / login");
													
					)
				
	



