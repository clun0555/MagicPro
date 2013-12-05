define ["./module"], (filters) ->
  "use strict"
  filters.filter "interpolate", ["version", (version) ->
    (text) ->
      String(text).replace /\%VERSION\%/g, version
  ]
