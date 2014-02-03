define [
	"underscore"
	"../shop-states"	
], (_, shop) ->

	shop.controller "CartController", ($scope, CartService, $state) ->

		$scope.checkout = ->
			$scope.hideDrawers()
			$state.go("cart")

		$scope.edit = ->
			$scope.hideDrawers()
			$state.go("cart")	

		$scope.continue = ->
			$scope.hideDrawers()			
			
		CartService.get().then (cart) -> $scope.cart = cart