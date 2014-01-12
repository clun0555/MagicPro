define [
	"underscore"
	"../shop-states"	
], (_, shop) ->

	shop.controller "BreadCrumbController", ($scope, $rootScope, ShopService, $state) ->
						
		$scope.$watch '$state.$current.locals.globals.data', (data) ->
			$scope.data = data
			$scope.search = ShopService.search