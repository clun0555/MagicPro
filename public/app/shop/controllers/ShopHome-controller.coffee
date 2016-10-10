define [
	"underscore"
	"../shop-states"	
], (_, shop) ->

	shop.controller "ShopHomeController", ($scope, data, $state, $interval) ->

		$scope.categories = data.categories
		$scope.slides = data.sliders
		$scope.featured = _.filter data.products, (product) -> product.featured
		$scope.homeImage = { 
			# 'path': 'home5.jpg'
			# 'width': '2552'
			# 'height': '1135'

			'path': 'home9.jpg'
			'width': '4380'
			'height': '1910'

		}


		$scope.currentSlide = $scope.slides[0]

		nextSlide = ->
			nextIndex = $scope.slides.indexOf($scope.currentSlide) + 1
			nextIndex = if nextIndex >= $scope.slides.length then 0 else nextIndex
			$scope.currentSlide = $scope.slides[nextIndex]


		changingSlides = $interval nextSlide, 5000

		$scope.$on "$destroy", ->
			$interval.cancel changingSlides

		$scope.goToProduct = (product, state = "shop.product") ->
			$state.go state, { category: product.type.category.slug, type: product.type.slug, product: product.slug}
