define [
	"./controllers"
	"resources/translations/translations"
], (controllers, translations) ->
	
	controllers
		.controller "MenuController", ($scope, $rootScope, $translate, SessionService, $state, CartService, $timeout) ->

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
				$rootScope.info.leftDrawerVisible = !$rootScope.info.leftDrawerVisible

			$scope.toggleCart = ->
				# alert "helo"
				$rootScope.info.cartVisible = !$rootScope.info.cartVisible
				return
				# $scope.info.leftDrawerVisible = !$scope.info.leftDrawerVisible
				# $scope.isCollapsed = !$scope.isCollapsed

			$scope.logout = ->
				SessionService.logout().then -> $state.go "index"

			$scope.isCurrentMenu = (state) ->
				$rootScope.nextState?.name.indexOf(state) >= 0 or $rootScope.$state.includes(state)

			$scope.changeMenu = (state) ->
				$rootScope.nextState = $state.get(state)
				$state.go state

			$scope.$on "user:changed", -> 
				if $scope.user?
					CartService.get().then (cart) -> $scope.cart = cart
				else
					$scope.cart = null

			$scope.$on "cart:changed", ->
				$scope.update = true
				$timeout.cancel($scope.cartTimeout)
				$scope.cartTimeout = $timeout ->
					$scope.update = false
				, 2000
				# $scope.showCart = ->
			# 	snapRemote.toggle("right")	
			# 	console.log $scope.cartVisible

				
					
	



