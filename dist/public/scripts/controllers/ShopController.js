(function() {
  define(["./module"], function(controllers) {
    return controllers.controller("ShopCategoriesController", function($scope, data, ShopService, StateService) {
      $scope.categories = data.categories;
      StateService.category = data.category;
      StateService.type = data.type;
      return StateService.product = data.product;
    }).controller("ShopTypesController", function($scope, data, StateService) {
      StateService.category = data.category;
      StateService.type = data.type;
      StateService.product = data.product;
      return $scope.category = data.category;
    }).controller("ShopProductsController", function($scope, data, StateService) {
      StateService.category = data.category;
      StateService.type = data.type;
      StateService.product = data.product;
      return $scope.products = data.products;
    }).controller("ShopProductController", function($scope, data, CartService, StateService) {
      $scope.quantities = CartService.quantities(data.product);
      $scope.product = data.product;
      StateService.category = data.category;
      StateService.type = data.type;
      StateService.product = data.product;
      $scope.cart = CartService.get();
      return $scope.updateQuantity = function(design) {
        var quantity;
        quantity = $scope.quantities[design._id];
        return CartService.update($scope.product, design, quantity);
      };
    }).controller("BreadCrumbController", function($scope, CartService, StateService) {
      return $scope.state = StateService;
    }).controller("CartController", function($scope, CartService) {
      return $scope.cart = CartService.get();
    });
  });

}).call(this);
