(function() {
  define(["./module", "underscore"], function(services, _) {
    return services.service("ShopService", function($resource, $q) {
      return {
        getCategories: function() {
          var deferred,
            _this = this;
          deferred = $q.defer();
          this.categories = $resource("api/categories").query(function() {
            return deferred.resolve({
              categories: _this.categories
            });
          });
          return deferred.promise;
        },
        getCategoryBySlug: function(categorySlug) {
          var deferred;
          deferred = $q.defer();
          this.getCategories().then(function(data) {
            var category;
            category = _.findWhere(data.categories, {
              slug: categorySlug
            });
            return deferred.resolve({
              category: category
            });
          });
          return deferred.promise;
        },
        getTypeBySlug: function(categorySlug, typeSlug) {
          var deferred;
          deferred = $q.defer();
          this.getCategoryBySlug(categorySlug).then(function(data) {
            var type;
            type = _.findWhere(data.category.types, {
              slug: typeSlug
            });
            type.category = data.category;
            return deferred.resolve({
              type: type,
              category: data.category
            });
          });
          return deferred.promise;
        },
        getProductsByCategoryTypeSlug: function(categorySlug, typeSlug) {
          var deferred;
          deferred = $q.defer();
          this.getTypeBySlug(categorySlug, typeSlug).then(function(data) {
            var products;
            return products = $resource("api/products?type=" + data.type._id).query(function() {
              var product, _i, _len;
              for (_i = 0, _len = products.length; _i < _len; _i++) {
                product = products[_i];
                product.type = data.type;
              }
              return deferred.resolve({
                products: products,
                type: data.type,
                category: data.type.category
              });
            });
          });
          return deferred.promise;
        },
        getProductBySlug: function(categorySlug, typeSlug, productSlug) {
          var deferred, products,
            _this = this;
          deferred = $q.defer();
          products = $resource("api/products?slug=" + productSlug).query(function() {
            var product;
            product = products[0];
            return _this.getTypeBySlug(categorySlug, typeSlug, productSlug).then(function(data) {
              product.type = data.type;
              return deferred.resolve({
                product: product,
                type: product.type,
                category: product.type.category
              });
            });
          });
          return deferred.promise;
        }
      };
    });
  });

}).call(this);
