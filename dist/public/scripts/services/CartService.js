(function() {
  define(["./module", "underscore", "models/Cart"], function(services, _, Cart) {
    return services.service("CartService", function($resource, $q) {
      var Carts, cart;
      Carts = $resource("api/carts/:_id");
      cart = new Cart();
      return {
        update: function(product, design, quantity) {
          return cart.updateBundle(product, design, quantity);
        },
        quantities: function(product) {
          var bundle, composition, quantities, _i, _len, _ref;
          quantities = {};
          if ((bundle = cart.getBundle(product._id)) != null) {
            _ref = bundle.compositions;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              composition = _ref[_i];
              quantities[composition.design._id] = composition.quantity;
            }
          }
          return quantities;
        },
        get: function() {
          return cart;
        },
        save: function() {
          var deferred, jsonCart;
          deferred = $q.defer();
          jsonCart = JSON.parse(JSON.stringify(cart));
          Carts.save({}, jsonCart, function() {
            cart.reset();
            return deferred.resolve();
          });
          return deferred.promise();
        }
      };
    });
  });

}).call(this);
