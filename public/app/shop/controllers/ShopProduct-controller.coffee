define [
	"underscore"
	"../shop-states"	
], (_, shop) ->

	shop.controller "ShopProductController", ($scope, data, cart, CartService, ShopService, $translate, $state) ->
		$scope.product = data.product					
		$scope.cart = cart
		$scope.quantities = cart.quantities(data.product)
		$scope.currentDesign = $scope.product.designs[0]
		
		$scope.currentImage = ->
			$scope.currentDesign?.image ? $scope.product.image

		$scope.selectDesign = (design) ->
			# $scope.$apply ->
			$scope.currentDesign = design

		$scope.updateQuantity = (design) ->			
			quantity = $scope.quantities[design._id]
			CartService.update $scope.product, design, quantity

		$scope.addToCart  = (design) ->
			$scope.quantities[design._id] = 1
			$scope.updateQuantity design

		$scope.removeFromCart  = (design) ->
			$scope.quantities[design._id] = 0
			$scope.updateQuantity design

		$scope.focusCartButton = (product, design, currentScope) ->
			currentScope.value = $scope.quantities[design._id]
			$scope.quantities[design._id] = ''

		$scope.blurCartButton = (product, design, currentScope) ->
			if $scope.quantities[design._id] == ''
				$scope.quantities[design._id] = currentScope.value

		$scope.removeProduct  = (product) ->
			msg = $translate('product.remove.confirmation', {title: product.title})
			if confirm(msg)
				ShopService.removeProduct(product).then ->
					$state.go "shop.products"		