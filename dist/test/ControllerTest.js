/*
Clones / deep copies an object.

@param Object obj
Any object.

@return Object
obj--cloned.
*/


(function() {
  var clone, expect,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  clone = function(obj) {
    var key, temp;
    if (obj === null || typeof obj !== "object") {
      return obj;
    }
    temp = new Object();
    for (key in obj) {
      temp[key] = clone(obj[key]);
    }
    return temp;
  };

  expect = chai.expect;

  describe("addOne Exemplary Tests2", function() {
    var Controller;
    Controller = void 0;
    /*
    	Instead of requiring add-one in each test--making each test async,
    	require it in beforeEach, clone it, and sneak it into a global
    	so that no test can (permanently) mess with / mutate it.
    */

    beforeEach(function(done) {
      return require(["base/utils/Controller"], function(_Controller) {
        Controller = clone(_Controller);
        return done();
      });
    });
    it("Should exist.", function() {
      return expect(Controller).to.exist;
    });
    return it("Should call action", function() {
      var TestController, _ref;
      TestController = (function(_super) {
        __extends(TestController, _super);

        function TestController() {
          _ref = TestController.__super__.constructor.apply(this, arguments);
          return _ref;
        }

        TestController.prototype.callMe = function() {};

        return TestController;

      })(Controller);
      return expect(Controller).to.exist;
    });
  });

}).call(this);
