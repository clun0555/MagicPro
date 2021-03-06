define [
	"underscore"
	"../shop-states"	
	"common/utils/utils"
], (_, shop, utils) ->

	shop.controller "ShopProductsController", ($scope, data, cart, ShopService, CartService, $state, SessionService) ->
		amount = 12
		from = amount
		allProducts = data.products
		# $scope.products = allProducts		
		$scope.products = allProducts.slice(0, amount)
		$scope.search = ShopService.search
		$scope.cart = cart
		$scope.categories = data.categories

		$scope.quantities = {}


		$scope.orders =  [
			{ field: 'identifier', asc: true }
			{ field: 'identifier', asc: false }
			{ field: 'category', asc: true }
			{ field: 'category', asc: false }
			{ field: 'title', asc: true }
			{ field: 'title', asc: false }
			{ field: 'price', asc: true }
			{ field: 'price', asc: false }
		]

		$scope.orderLabels =
			'identifier' : 'productnavigator.order.identifier'
			'category' : 'productnavigator.order.category'
			'title' : 'productnavigator.order.title'
			'price' : 'productnavigator.order.price'

		localOrder = SessionService.retrieveLocal("order")
		if localOrder? 
			$scope.currentOrder =  _.find $scope.orders, (order) -> localOrder.title is order.title and localOrder.asc is order.asc
		else
			$scope.currentOrder =  $scope.orders[2]
		
		for product in data.products
			$scope.quantities[product._id] = cart.quantities(product)		

		$scope.doPaging = ->
			$scope.loading = true
			if from < allProducts.length
				for product in  allProducts.slice(from, from+amount)
					$scope.products.push product  
				from += amount
				$scope.loading = false			

		$scope.doSort = (order, asc) ->
			if order.field is "identifier"
				allProducts.sort utils.sortBySorter('identifier', order.asc, (identifier) -> identifier.toUpperCase())
			else if order.field is "price"
				allProducts.sort utils.sortBySorter('price', order.asc, parseFloat)
			else if order.field is "title"
				allProducts.sort utils.sortBySorter('title', order.asc, (title) -> title.toUpperCase())
			else if order.field is "category"
				allProducts.sort utils.sortBySorter('type', order.asc, (type) -> type?.category?.order)
			
			$scope.products = allProducts.slice(0, $scope.products.length)

			$scope.currentOrder = order
			SessionService.storeLocal "order", order

		$scope.focusCartButton = (product, design, currentScope) ->
			currentScope.value = $scope.quantities[product._id][design._id]
			$scope.quantities[product._id][design._id] = ''

		$scope.blurCartButton = (product, design, currentScope) ->
			if $scope.quantities[product._id][design._id] == ''
				$scope.quantities[product._id][design._id] = currentScope.value


		$scope.updateQuantity = (product, design, value, currentScope) ->
			quantity = $scope.quantities[product._id][design._id]
			CartService.update product, design, quantity

		$scope.addToCart = (product, design) ->
			quantity = $scope.quantities[product._id][design._id] = 1
			CartService.update product, design, quantity

		$scope.removeFromCart = (product, design) ->
			quantity = $scope.quantities[product._id][design._id] = 0
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

		$scope.goToProduct = (product, state = "shop.product") ->
			$state.go state, { category: product.type.category.slug, type: product.type.slug, product: product.slug}


		# $scope.updateQuantity = (design) ->			
		# 	quantity = $scope.quantities[design._id]
		# 	CartService.update $scope.product, design, quantity

		# $scope.addToCart  = (product, design) ->
		# 	$scope.quantities[design._id] = 1
		# 	$scope.updateQuantity design

		# $scope.removeFromCart  = (design) ->
		# 	$scope.quantities[design._id] = 0
		# 	$scope.updateQuantity design
		
		$scope.$on "fileDrop", (event, $files) ->
			$scope.$parent.files = $files
			$state.go "shop.createproduct", { category: product.type.category.slug, type: product.type.slug, product: product.slug}

		$scope.doSort($scope.currentOrder)

