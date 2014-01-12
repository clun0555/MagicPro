define [
	"underscore"
	"../shop-states"	
], (_, shop) ->

	shop.controller "ShopTypesController", ($scope, data, ShopService) ->
		$scope.category = data.category
		$scope.search = ShopService.search

	