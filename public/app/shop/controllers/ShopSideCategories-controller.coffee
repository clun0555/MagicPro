define [
	"underscore"
	"../shop-states"	
], (_, shop) ->

	shop.controller "ShopSideCategoriesController", ($scope, data, ShopService, $state, SessionService) ->						
		
		$scope.isCategoryActive = (category) ->
			# return true if $scope.selectedCategory is category and $scope.selectedType == null
			return true if $scope.$state.includes('shop.productsbycategory') && $scope.$stateParams.category == category.slug
		
		$scope.isTypeActive = (category, type) ->
			# return true if $scope.selectedType is type
			return true if $scope.$state.includes('shop.productsbytype') && $scope.$stateParams.type == type.slug
			return true if $scope.$state.includes('shop.product') && $scope.$stateParams.type == type.slug
			
		$scope.isCategoryToggled = (category) ->
			return true if $scope.selectedCategory is category
			return true if $scope.$state.includes('shop.productsbycategory') && $scope.$stateParams.category == category.slug
			return true if $scope.$state.includes('shop.productsbytype') && $scope.$stateParams.category == category.slug
			return true if $scope.$state.includes('shop.product') && $scope.$stateParams.category == category.slug
		

		$scope.searchProduct = ->
			$state.go "shop.search", searchInput: ShopService.search.title

		$scope.logout = ->
			SessionService.logout().then -> $state.go "index"

		$scope.categories = data.categories
		$scope.search = ShopService.search