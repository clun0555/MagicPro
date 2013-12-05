(function() {
  define(["underscore"], function(_) {
    var Composition;
    return Composition = (function() {
      function Composition(options) {
        this.design = options.design;
      }

      Composition.prototype.toJSON = function() {
        return {
          quantity: this.quantity,
          design: this.design._id
        };
      };

      return Composition;

    })();
  });

}).call(this);
