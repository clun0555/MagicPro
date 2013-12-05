(function() {
  var Category, _;

  Category = require("../models/category");

  _ = require("underscore");

  module.exports = {
    options: {
      name: 'api/categories',
      id: 'category'
    },
    index: function(req, res) {
      return res.send(Category.find());
    },
    show: function(req, res) {
      return res.send(Category.findById(req.params.category));
    },
    create: function(req, res) {
      var category;
      category = new Category(_.extend({}, req.body));
      return category.save(function(err, category) {
        return res.send(err || category);
      });
    },
    update: function(req, res) {
      return Category.findById(req.params.category, function(err, category) {
        if (err) {
          return res.send(err);
        } else if (category == null) {
          return res.send("Missing category");
        } else {
          _.extend(category, req.body);
          return category.save(function(err, category) {
            return res.send(err || category);
          });
        }
      });
    },
    destroy: function(req, res) {
      return res.send(Category.findByIdAndRemove(req.params.category));
    }
  };

}).call(this);
