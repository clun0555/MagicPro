define [
	"underscore"
	"../shop-states"
	"jquery"	
], (_, shop, $) ->

	shop.controller "ShopHomeController", ($scope, data, $state) ->

		$scope.categories = data.categories
		$scope.featured = _.filter data.products, (product) -> product.featured
		$scope.homeImage = { 
			'path': 'home.jpg'
			'width': '6999'
			'height': '3629'
		}

		screens = $('.home > *')

		$scope.goToProduct = (product, state = "shop.product") ->
			$state.go state, { category: product.type.category.slug, type: product.type.slug, product: product.slug}


		