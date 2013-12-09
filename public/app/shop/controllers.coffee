define [
	"./shop"
], (shop) ->
	
	shop
		
		.controller "ShopCategoriesController", ($scope, data, ShopService) ->						
			$scope.categories = data.categories

		.controller "ShopTypesController", ($scope, data) ->
			$scope.category = data.category

		.controller "ShopProductsController", ($scope, data) ->
			$scope.products = data.products
		
		.controller "ShopProductController", ($scope, data, CartService) ->
			
			$scope.quantities = CartService.quantities(data.product)
			$scope.product = data.product					
			$scope.cart = CartService.get()

			$scope.updateQuantity = (design) ->
				quantity = $scope.quantities[design._id]
				CartService.update $scope.product, design, quantity
				
		.controller "BreadCrumbController", ($scope, CartService, $rootScope, $state) ->
						
			$scope.$watch '$state.$current.locals.globals.data', (data) ->
				$scope.data = data
			
		.controller "CartController", ($scope, CartService) ->
			$scope.cart = CartService.get()

		.controller "CartPreviewController", ($scope, CartService) ->
			$scope.cart = CartService.get()
			
			$scope.submit = ->
				CartService.save().then ->
					$scope.saved = true		
		




