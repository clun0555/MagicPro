define [
	"underscore"
	"../shop-states"	
], (_, shop) ->

	shop.controller  "CartPreviewController", ($scope, cart, CartService) ->
			
		$scope.cart = cart.clone()			
		
		$scope.submit = ->
			CartService.save().then ->
				$scope.saved = true	

		$scope.remove = (bundle, composition) ->
			# remove in master cart
			CartService.update bundle.product, composition.design, 0

			# remove in cart preview
			$scope.cart.updateBundle bundle.product, composition.design, 0


		$scope.updateQuantity = (design, product, quantity) ->
			CartService.update product, design, quantity