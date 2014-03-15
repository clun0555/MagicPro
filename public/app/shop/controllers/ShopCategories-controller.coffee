define [
	"underscore"
	"../shop-states"	
], (_, shop) ->

	shop.controller "ShopCategoriesController", ($scope, ShopService) ->						
		# $scope.categories = data.categories
		$scope.search = ShopService.search