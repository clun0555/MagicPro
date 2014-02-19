define [
	"underscore"
	"../shop-states"	
], (_, shop) ->

	shop.controller "ShopHomeController", ($scope, data, $state) ->

		$scope.categories = data.categories
		$scope.featured = _.filter data.products, (product) -> product.featured
		$scope.homeImage = { 
			'path': 'home5.jpg'
			'width': '2552'
			'height': '1135'

		}

		$scope.goToProduct = (product, state = "shop.product") ->
			$state.go state, { category: product.type.category.slug, type: product.type.slug, product: product.slug}
