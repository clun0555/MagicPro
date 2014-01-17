define [
	"underscore"
	"../shop-states"	
], (_, shop) ->

	shop.controller "CategoryChooserController", ($scope, $modalInstance, categories, currentType) ->
		$scope.categories = categories.categories
		$scope.selected = type: currentType

		$scope.select = (type) ->
			$scope.selected = type: type
			$modalInstance.close(type)
		