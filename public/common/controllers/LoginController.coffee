define [
	"./controllers"
	"resources/translations/translations"
], (controllers, translations) ->
	
	controllers
		.controller "LoginController", ($scope, $state, SessionService) ->
			
			$scope.login = ->
				SessionService.login($scope.email, $scope.password).then(
					
					->
						$state.go "shop.categories"
					->
						alert "fail"
												
				)
				
	



