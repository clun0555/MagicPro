define [
	"./controllers"
	"resources/translations/translations"
], (controllers, translations) ->
	
	controllers
		.controller "MenuController", ($scope, $rootScope, $translate, SessionService, $state, CartService) ->

			$scope.isCollapsed = true
			# $scope.isCollapsed = true

			# snapRemote.getSnapper().then (snapper) ->
			# 	snapper.on 'open', ->
			# 		$scope.safeApply ->
			# 			$scope.cartVisible = true

			# 	snapper.on 'close', ->
			# 		$scope.safeApply ->
			# 			$scope.cartVisible = false
		
			$scope.toggle = ->
				$scope.info.leftDrawerVisible = !$scope.info.leftDrawerVisible
				# $scope.isCollapsed = !$scope.isCollapsed

			$scope.logout = ->
				SessionService.logout().then -> $state.go "index"



			$scope.$on "user:changed", -> 
				if $scope.user?
					CartService.get().then (cart) -> $scope.cart = cart

			# $scope.showCart = ->
			# 	snapRemote.toggle("right")	
			# 	console.log $scope.cartVisible

				
					
	



