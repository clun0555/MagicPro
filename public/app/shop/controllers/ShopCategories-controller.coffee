define [
	"underscore"
	"../shop-states"	
], (_, shop) ->

	shop.controller "ShopCategoriesController", ($scope, data, ShopService) ->						
		$scope.categories = data.categories
		$scope.search = ShopService.search