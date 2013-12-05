(function() {
  define(["./module"], function(controllers) {
    return controllers.controller("CartPreviewController", function($scope, CartService) {
      $scope.cart = CartService.get();
      return $scope.submit = function() {
        return CartService.save().then(function() {
          return $scope.saved = true;
        });
      };
    });
  });

}).call(this);
