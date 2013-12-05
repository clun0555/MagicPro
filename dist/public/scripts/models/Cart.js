(function() {
  define(["underscore", "models/Bundle"], function(_, Bundle) {
    var Cart;
    return Cart = (function() {
      function Cart() {
        this.bundles = [];
      }

      Cart.prototype.updateBundle = function(product, design, quantity) {
        var bundle, isNew;
        bundle = this.getBundle(product._id);
        if (bundle == null) {
          isNew = true;
          bundle = new Bundle({
            product: product
          });
        }
        bundle.updateComposition(design, quantity);
        if (bundle.isEmpty()) {
          return this.removeBundle(bundle);
        } else if (isNew) {
          return this.bundles.push(bundle);
        }
      };

      Cart.prototype.getBundle = function(productId) {
        return _.find(this.bundles, function(bundle) {
          return bundle.product._id === productId;
        });
      };

      Cart.prototype.removeBundle = function(bundle) {
        var index;
        if ((index = this.bundles.indexOf(bundle))) {
          return this.bundles.splice(index, 1);
        }
      };

      Cart.prototype.price = function(product, designId) {
        var bundle;
        if ((product != null) && (designId != null)) {
          bundle = this.getBundle(product.id);
          if (bundle != null) {
            return bundle.price(designId);
          } else {
            return 0;
          }
        } else {
          return _.reduce(this.bundles, (function(memo, bundle) {
            return memo + bundle.price();
          }), 0);
        }
      };

      Cart.prototype.quantity = function(product, designId) {
        var bundle;
        if ((product != null) && (designId != null)) {
          bundle = this.getBundle(product.id);
          if (bundle != null) {
            return bundle.quantity(designId);
          } else {
            return 0;
          }
        } else {
          return _.reduce(this.bundles, (function(memo, bundle) {
            return memo + bundle.quantity();
          }), 0);
        }
      };

      Cart.prototype.isEmpty = function() {
        return this.bundles.lenght === 0;
      };

      Cart.prototype.reset = function() {
        return this.bundles = [];
      };

      Cart.prototype.toJSON = function() {
        return {
          bundles: this.bundles
        };
      };

      return Cart;

    })();
  });

}).call(this);
