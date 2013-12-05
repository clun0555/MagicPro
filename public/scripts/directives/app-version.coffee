define ["./module"], (directives) ->
  "use strict"
  directives.directive "appVersion", ["version", (version) ->
    (scope, elm) ->
      elm.text version
  ]
