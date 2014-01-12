define [
	"underscore"
	"../shop-states"	
], (_, shop) ->

	shop.controller "CartController", ($scope, CartService) ->
			
		CartService.get().then (cart) -> $scope.cart = cart