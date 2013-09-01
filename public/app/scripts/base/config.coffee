define [
  
  "marionette"

], (Marionette) ->

  # use compiled templates by default
  Marionette.Renderer.render = (template, data) ->
    template data

