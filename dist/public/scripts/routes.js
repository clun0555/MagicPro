/*
Defines the main routes in the application.
The routes you see here will be anchors '#/' unless specifically configured otherwise.
*/


(function() {
  define(["app"], function(app) {
    return app.config(function($stateProvider, $urlRouterProvider) {
      var breadcrumb, cart;
      breadcrumb = {
        templateUrl: "views/breadcrumb.html",
        controller: "BreadCrumbController"
      };
      cart = {
        templateUrl: "views/cart.html",
        controller: "CartController"
      };
      $urlRouterProvider.otherwise("/products");
      return $stateProvider.state("shop", {
        abstract: true,
        templateUrl: "views/shop.html"
      }).state("shop.categories", {
        url: "/products",
        resolve: {
          data: function($stateParams, ShopService) {
            return ShopService.getCategories();
          },
          alan: function() {
            return "Hello Alan";
          }
        },
        views: {
          "breadcrumb": breadcrumb,
          "cart": cart,
          "navigator": {
            templateUrl: "views/categories.html",
            controller: "ShopCategoriesController"
          }
        }
      }).state("shop.types", {
        url: "/products/:category",
        resolve: {
          data: function($stateParams, ShopService) {
            return ShopService.getCategoryBySlug($stateParams.category);
          }
        },
        views: {
          "breadcrumb": breadcrumb,
          "cart": cart,
          "navigator": {
            templateUrl: "views/types.html",
            controller: "ShopTypesController"
          }
        }
      }).state("shop.products", {
        url: "/products/:category/:type",
        resolve: {
          data: function($stateParams, ShopService) {
            return ShopService.getProductsByCategoryTypeSlug($stateParams.category, $stateParams.type);
          }
        },
        views: {
          "breadcrumb": breadcrumb,
          "cart": cart,
          "navigator": {
            templateUrl: "views/products.html",
            controller: "ShopProductsController"
          }
        }
      }).state("shop.product", {
        url: "/products/:category/:type/:product",
        resolve: {
          data: function($stateParams, ShopService) {
            return ShopService.getProductBySlug($stateParams.category, $stateParams.type, $stateParams.product);
          }
        },
        views: {
          "breadcrumb": breadcrumb,
          "cart": cart,
          "navigator": {
            templateUrl: "views/product.html",
            controller: "ShopProductController"
          }
        }
      }).state("cart", {
        url: "/cart",
        templateUrl: "views/cart_preview.html",
        controller: "CartPreviewController"
      });
    });
  });

}).call(this);
