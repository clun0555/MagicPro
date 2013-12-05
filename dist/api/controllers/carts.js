(function() {
  var Cart, User, email, json2csv, sendConfirmationEmail, _;

  Cart = require("../models/cart");

  User = require("../models/user");

  _ = require("underscore");

  email = require("../utils/email");

  json2csv = require('json2csv');

  module.exports = {
    options: {
      name: 'api/carts',
      id: 'cart'
    },
    index: function(req, res) {
      return res.send(Cart.find());
    },
    show: function(req, res) {
      return res.send(Cart.findOne({
        _id: req.params.cart
      }));
    },
    create: function(req, res) {
      var cart;
      cart = new Cart(_.extend({}, req.body));
      return cart.save(function(err, cart) {
        if (err != null) {
          return res.send(err);
        }
        sendConfirmationEmail(cart, req.user);
        return res.send(cart);
      });
    },
    update: function(req, res) {
      return Cart.findById(req.params.cart, function(err, cart) {
        if (err) {
          return res.send(err);
        } else if (cart == null) {
          return res.send("Missing cart");
        } else {
          _.extend(cart, req.body);
          return cart.save(function(err, cart) {
            return res.send(err || cart);
          });
        }
      });
    },
    destroy: function(req, res) {
      return res.send(Cart.findByIdAndRemove(req.params.cart));
    }
  };

  sendConfirmationEmail = function(cart, user) {
    var cartJSON, designs,
      _this = this;
    cartJSON = cart.toJSON();
    designs = [];
    return cart.populate("bundles.product", function() {
      var bundle, composition, design, _i, _j, _len, _len1, _ref, _ref1;
      _ref = cart.bundles;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        bundle = _ref[_i];
        _ref1 = bundle.compositions;
        for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
          composition = _ref1[_j];
          design = _.findWhere(bundle.product.designs, {
            id: composition.design.toJSON()
          });
          designs.push({
            "itemId": bundle.product.identifier,
            "designId": design.identifier,
            "quantity": composition.quantity,
            "unitPrice": bundle.product.price
          });
        }
      }
      return json2csv({
        data: designs,
        fields: ['itemId', 'designId', 'quantity', 'unitPrice'],
        fieldNames: ['Item Id', 'Design Id', 'Quantity', 'Unit Price']
      }, function(err, csv) {
        var options;
        options = {
          subject: "Magic Pro Order",
          text: csv,
          to: user.email,
          attachments: [
            {
              fileName: "order.csv",
              contents: csv
            }
          ]
        };
        return email.send(options);
      });
    });
  };

}).call(this);
