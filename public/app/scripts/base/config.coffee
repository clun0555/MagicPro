define [

  "underscore"
  "marionette"
  "base/utils/TemplateHelpers"

], (_, Marionette, TemplateHelper) ->

  # use compiled templates by default
  Marionette.Renderer.render = (template, data) ->
    data = _.extend data, TemplateHelper
    template data

