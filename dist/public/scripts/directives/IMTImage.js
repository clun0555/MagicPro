(function() {
  define(["./module"], function(directives) {
    return directives.directive("imtImage", function() {
      return {
        restrict: "E",
        template: '<img class="{{class}}" src="http://image-resizer-magicpro.herokuapp.com/{{src}}?{{size}}" >',
        scope: {
          src: '@',
          size: '@',
          "class": '@'
        }
      };
    });
  });

}).call(this);
