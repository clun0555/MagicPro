define [

  "Base"
  "App"
  "templates/logo"

], (Base, App, template) ->

  class LogoView extends Base.ItemView

    className: "logo-view container"
    template: template

    initialize: ->
      @render