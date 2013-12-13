define [
	"./shop"
	"common/models/Cart"
], (shop, Cart) ->
	
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
		
		.controller "ShopProductController", ($scope, data, cart, CartService) ->
			
			$scope.product = data.product					
			$scope.cart = cart
			$scope.quantities = cart.quantities(data.product)

			$scope.updateQuantity = (design, product, quantity) ->
				quantity = $scope.quantities[design._id]
				CartService.update $scope.product, design, quantity
				
		.controller "BreadCrumbController", ($scope, $rootScope, ShopService, $state) ->
						
			$scope.$watch '$state.$current.locals.globals.data', (data) ->
				$scope.data = data
				$scope.search = ShopService.search
			
		.controller "CartController", ($scope, CartService) ->
			
			CartService.get().then (cart) -> $scope.cart = cart
				

		.controller "CartPreviewController", ($scope, cart, CartService) ->
			
			$scope.cart = cart.clone()			
			
			$scope.submit = ->
				CartService.save().then ->
					$scope.saved = true	

			$scope.updateQuantity = (design, product, quantity) ->
				CartService.update product, design, quantity
		




