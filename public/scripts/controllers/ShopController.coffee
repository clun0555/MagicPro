define [
	"./module"
], (controllers) ->
	
	controllers
		
		.controller "ShopCategoriesController", ($scope, data, ShopService, StateService) ->
						
			$scope.categories = data.categories
			StateService.category = data.category
			StateService.type = data.type
			StateService.product = data.product

		.controller "ShopTypesController", ($scope, data, StateService) ->
					
			StateService.category = data.category
			StateService.type = data.type
			StateService.product = data.product
			$scope.category = data.category

		.controller "ShopProductsController", ($scope, data, StateService) ->

			StateService.category = data.category
			StateService.type = data.type
			StateService.product = data.product
			$scope.products = data.products
		
		.controller "ShopProductController", ($scope, data, CartService, StateService) ->
			
			$scope.quantities = CartService.quantities(data.product)
			$scope.product = data.product		
			StateService.category = data.category
			StateService.type = data.type
			StateService.product = data.product
			$scope.cart = CartService.get()

			$scope.updateQuantity = (design) ->
				quantity = $scope.quantities[design._id]
				CartService.update $scope.product, design, quantity

				
		.controller "BreadCrumbController", ($scope, CartService, StateService) ->
			$scope.state = StateService	
		
		.controller "CartController", ($scope, CartService) ->
			$scope.cart = CartService.get()
		




