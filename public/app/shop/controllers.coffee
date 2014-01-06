define [
	"underscore"
	"./shop-states"
	"common/models/Cart"
], (_, shop, Cart) ->
	
	shop
		
		.controller "ShopCategoriesController", ($scope, data, ShopService) ->						
			$scope.categories = data.categories
			$scope.search = ShopService.search

		.controller "ShopTypesController", ($scope, data, ShopService) ->
			$scope.category = data.category
			$scope.search = ShopService.search

		.controller "ShopProductsController", ($scope, data, cart, ShopService, CartService, $state) ->
			$scope.products = data.products
			$scope.search = ShopService.search
			$scope.cart = cart

			$scope.quantities = {}

			for product in data.products
				$scope.quantities[product._id] = cart.quantities(product)

			$scope.updateQuantity = (product, design) ->
				quantity = $scope.quantities[product._id][design._id]
				CartService.update product, design, quantity

			$scope.navigateToProduct = (product) ->
				if $scope.hover is product
					$state.go 'shop.product', { category: product.type.category.slug, type: product.type.slug, product: product.slug}				

			$scope.activateProductHover = (product) ->
				
				# prevent ipad unwanted hover on click 
				if not _.has(document.documentElement, 'ontouchstart')
					$scope.hover = product 
				

			$scope.unActivateProduct = (product) ->
				return if $scope.hover isnt product
				$scope.hover = null
				return

			$scope.activateProductClick = (product) ->
				return if $scope.hover is product
				$scope.hover = product 
				setTimeout ->
					angular.element(".product_#{product._id} .design_quantity_0").focus()
				, 0
				return

			$scope.focusDesign = (design, $scope) ->
				$scope.focusedDesign = design
				return 

			$scope.blurDesign = ($scope) ->
				$scope.focusedDesign = null
				return 

			$scope.getImageId = (product, design, $scope) ->
				return design.imageId if design.imageId?
				product.imageId
			
		
		.controller "ShopProductController", ($scope, data, cart, CartService) ->
			
			$scope.product = data.product					
			$scope.cart = cart
			$scope.quantities = cart.quantities(data.product)

			$scope.updateQuantity = (design) ->
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

			$scope.remove = (bundle, composition) ->
				# remove in master cart
				CartService.update bundle.product, composition.design, 0

				# remove in cart preview
				$scope.cart.updateBundle bundle.product, composition.design, 0


			$scope.updateQuantity = (design, product, quantity) ->
				CartService.update product, design, quantity
		




