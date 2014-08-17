define [
	"underscore"
	"../shop-states"	
], (_, shop) ->

	shop.controller  "CartPreviewController", ($scope, cart, CartService, $state) ->

		$scope.cart = cart.clone()

		$scope.cart.method = if cart.method then cart.method else "Delivery"

		$scope.$watch 'cart.note', ->
			CartService.updateNote $scope.cart.note

		$scope.changeMethod = (method) ->
			$scope.cart.method = method
			CartService.updateMethod $scope.cart.method

		# $scope.updateNote = ->
		# 	# $scope.cart.method = method
		# 	CartService.store()

		$scope.submit = ->
			CartService.save().then ->
				$scope.saved = true
			$state.go 'checkout', ''

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

