(function() {
  var Product, _;

  Product = require("../models/product");

  _ = require("underscore");

  module.exports = {
    options: {
      name: 'api/products',
      id: 'product'
    },
    index: function(req, res) {
      if (req.query != null) {
        return res.send(Product.find(req.query));
      } else {
        return res.send(Product.find());
      }
    },
    show: function(req, res) {
      return res.send(Product.findById(req.params.product));
    },
    create: function(req, res) {
      var product;
      product = new Product(_.extend({}, req.body));
      return product.save(function(err, product) {
        return res.send(err || product);
      });
    },
    update: function(req, res) {
      return Product.findById(req.params.product, function(err, product) {
        if (err) {
          return res.send(err);
        } else if (product == null) {
          return res.send("Missing product");
        } else {
          _.extend(product, req.body);
          return product.save(function(err, product) {
            return res.send(err || product);
          });
        }
      });
    },
    destroy: function(req, res) {
      return res.send(Product.findByIdAndRemove(req.params.product));
    }
  };

}).call(this);
