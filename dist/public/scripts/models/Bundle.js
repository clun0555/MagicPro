(function() {
  define(["underscore", "models/Composition"], function(_, Composition) {
    var Bundle;
    return Bundle = (function() {
      function Bundle(options) {
        this.product = options.product;
        this.compositions = [];
      }

      Bundle.prototype.updateComposition = function(design, quantity) {
        var composition;
        composition = this.getOrCreateComposition(design);
        if (quantity) {
          composition.quantity = parseInt(quantity, 10);
          if (!_.contains(this.compositions, composition)) {
            return this.compositions.push(composition);
          }
        } else {
          return this.removeComposition(composition);
        }
      };

      Bundle.prototype.getOrCreateComposition = function(design) {
        var _ref;
        return (_ref = this.getComposition(design._id)) != null ? _ref : new Composition({
          design: design
        });
      };

      Bundle.prototype.getComposition = function(designId) {
        return _.find(this.compositions, function(composition) {
          return composition.design._id === designId;
        });
      };

      Bundle.prototype.removeComposition = function(composition) {
        var index;
        if (_.contains(this.compositions, composition)) {
          index = this.compositions.indexOf(composition);
          return this.compositions.splice(index, 1);
        }
      };

      Bundle.prototype.isEmpty = function() {
        return this.compositions.length === 0;
      };

      Bundle.prototype.quantity = function(designId) {
        var composition, _ref;
        if (designId != null) {
          composition = this.getComposition(designId);
          return (_ref = composition != null ? composition.quantity : void 0) != null ? _ref : 0;
        } else {
          return _.reduce(this.compositions, (function(memo, model) {
            return memo + model.quantity;
          }), 0);
        }
      };

      Bundle.prototype.price = function(designId) {
        return this.quantity(designId) * this.product.price;
      };

      Bundle.prototype.toJSON = function() {
        return {
          compositions: this.compositions,
          product: this.product._id
        };
      };

      return Bundle;

    })();
  });

}).call(this);
