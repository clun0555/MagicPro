define [
	"./shop"
], (shop) ->
	
	shop
		
		.controller "ShopCategoriesController", ($scope, data, ShopService) ->						
			$scope.categories = data.categories
			$scope.search = ShopService.search

		.controller "ShopTypesController", ($scope, data, ShopService) ->
			$scope.category = data.category
			$scope.search = ShopService.search

		.controller "ShopProductsController", ($scope, data, ShopService) ->
			$scope.products = data.products
			$scope.search = ShopService.search
		
		.controller "ShopProductController", ($scope, data, CartService) ->
			
			$scope.quantities = CartService.quantities(data.product)
			$scope.product = data.product					
			$scope.cart = CartService.get()

			$scope.updateQuantity = (design) ->
				quantity = $scope.quantities[design._id]
				CartService.update $scope.product, design, quantity
				
		.controller "BreadCrumbController", ($scope, CartService, $rootScope, ShopService, $state) ->
						
			$scope.$watch '$state.$current.locals.globals.data', (data) ->
				$scope.data = data
				$scope.search = ShopService.search
			
		.controller "CartController", ($scope, CartService) ->
			$scope.cart = CartService.get()

		.controller "CartPreviewController", ($scope, CartService) ->
			$scope.cart = CartService.get()
			
			$scope.submit = ->
				CartService.save().then ->
					$scope.saved = true		
		




