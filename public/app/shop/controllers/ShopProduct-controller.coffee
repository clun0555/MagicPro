define [
	"underscore"
	"../shop-states"	
], (_, shop) ->

	shop.controller "ShopProductController", ($scope, data, cart, CartService) ->
		$scope.product = data.product					
		$scope.cart = cart
		$scope.quantities = cart.quantities(data.product)

		$scope.updateQuantity = (design) ->
			quantity = $scope.quantities[design._id]
			CartService.update $scope.product, design, quantity