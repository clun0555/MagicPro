define [
	"underscore"
	"../shop-states"	
], (_, shop) ->

	shop.controller  "CartPreviewController", ($scope, cart, CartService) ->

		$scope.cart = cart.clone()

		$scope.cart.method = if cart.method then cart.method else "Delivery"

		$scope.changeMethod = ->
			CartService.updateMethod $scope.cart.method

		$scope.submit = ->
			CartService.save().then ->
				$scope.saved = true	

		$scope.reAdd = (composition) ->
			composition.quantity = 1
			$scope.updateQuantity composition

		$scope.remove = (composition) ->

			# remove in master cart
			CartService.update composition.product, composition.design, 0

			# remove in cart preview
			$scope.cart.updateBundle composition.product, composition.design, 0


		$scope.updateQuantity = (composition) ->
			CartService.update composition.product, composition.design, composition.quantity

		$scope.focusCartButton = (composition, currentScope) ->
			currentScope.value = composition.quantity
			composition.quantity = ''

		$scope.blurCartButton = (composition, currentScope) ->
			if composition.quantity == ''
				composition.quantity = currentScope.value