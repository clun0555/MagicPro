define [
	"./module"
], (controllers) ->
	
	controllers
		.controller "CartPreviewController", ($scope, CartService) ->
			$scope.cart = CartService.get()
			
			$scope.submit = ->
				CartService.save().then ->
					$scope.saved = true					
	



