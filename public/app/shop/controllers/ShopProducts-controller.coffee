define [
	"underscore"
	"../shop-states"	
], (_, shop) ->

	shop.controller "ShopProductsController", ($scope, data, cart, ShopService, CartService, $state) ->
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

		# $scope.getImage = (product, design, $scope) ->
		# 	design.image ? product.image
			

		$scope.$on "fileDrop", (event, $files) ->
			$scope.$parent.files = $files
			$state.go "shop.createproduct", { category: product.type.category.slug, type: product.type.slug, product: product.slug}

