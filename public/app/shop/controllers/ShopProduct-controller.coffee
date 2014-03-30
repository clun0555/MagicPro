define [
	"underscore"
	"../shop-states"	
], (_, shop) ->

	shop.controller "ShopProductController", ($scope, data, ShopService, $state, $translate) ->
		$scope.product = data.product					
		# $scope.cart = cart
		# $scope.quantities = cart.quantities(data.product)
		$scope.currentDesign = $scope.product.designs[0]

		$scope.currentImage = ->
			$scope.currentDesign?.image ? $scope.product.image

		$scope.selectDesign = (design) ->
			# $scope.$apply ->
			$scope.currentDesign = design

		$scope.removeProduct  = (product, msg) ->
			msg = $translate('product.remove.confirmation', {title: product.title})
			if confirm(msg)
				ShopService.removeProduct(product).then ->
					$state.go "shop.products"		