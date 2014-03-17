define [
	"underscore"
	"../shop-states"	
	"common/utils/utils"
], (_, shop, utils) ->

	shop.controller "ShopProductsController", ($scope, data, ShopService, CartService, $state, SessionService) ->
		amount = 12
		from = amount
		
		# $scope.products = ({} for i in [0..9])
		$scope.products = []
		$scope.visibleLg = []
		$scope.visibleXs = []
		
		
		productsCount = $scope.productsCount = data.products.length

		for product, index in data.products
			# $scope.products[index] = product
			$scope.visibleLg.push index
			$scope.visibleXs.push index
			$scope.products.push product

		offset = 0

		if productsCount % 3 isnt 0
			offset = $scope.offset = (3-($scope.products.length%3))
			for i in [0..offset-1]
				$scope.products.push {}	
				$scope.visibleLg.push ($scope.products.length - 1)
				if $scope.products.length % 2 == 0
					$scope.visibleXs.push ($scope.products.length - 1)


		if $scope.products.length % 2 isnt 0 and offset in [1, 0]
			$scope.products.push {}
			$scope.visibleXs.push ($scope.products.length - 1)

		$scope.search = ShopService.search
		# $scope.cart = cart
		$scope.categories = data.categories
		$scope.category = data.category

		$scope.quantities = {}


		$scope.orders =  [
			{ field: 'price', asc: true }
			{ field: 'price', asc: false }
			{ field: 'title', asc: true }
			{ field: 'title', asc: false }
			{ field: 'category', asc: true }
			{ field: 'category', asc: false }
		]

		$scope.orderLabels = 
			'price' : 'productnavigator.order.price'
			'title' : 'productnavigator.order.title'
			'category' : 'productnavigator.order.category'

		localOrder = SessionService.retrieveLocal("order")
		if localOrder? 
			$scope.currentOrder =  _.find $scope.orders, (order) -> localOrder.title is order.title and localOrder.asc is order.asc
		else
			$scope.currentOrder =  $scope.orders[2]
		
		# for product in data.products
		# 	$scope.quantities[product._id] = cart.quantities(product)		

		
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

		$scope.goToProduct = (product, state = "shop.product") ->
			$state.go state, { category: product.type.category.slug, type: product.type.slug, product: product.slug}

		$scope.selectType = (type) ->
			$scope.currentType = type
			# $scope.filteredProducts = _.filter $scope.products, (p) -> p.type._id is type._id

		$scope.$on "fileDrop", (event, $files) ->
			$scope.$parent.files = $files
			$state.go "shop.createproduct", { category: product.type.category.slug, type: product.type.slug, product: product.slug}

		# $scope.doSort($scope.currentOrder)

