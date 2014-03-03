define [
	"jquery"
	"../shop-states"	
], ($, shop) ->

	shop.directive "imtCartButton", ->
		restrict: "A"
		templateUrl: "app/shop/views/cart_button.html"
		
		controller: ($scope, $element) ->
			$scope.focusOnInput = ->
				setTimeout ->
					unless $scope.isFocused
						$($element).find("input").select()
				, 0

				return


		link: (scope, elem, attr, ctrl) ->
			
			