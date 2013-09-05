###
	Main module. Called when dom is ready
	Responsable for initializing the Application.
	populating regions
	intializing data
###
define [
	
	"App"
	"utils/DataHandler"
  "utils/Translator"
	"views/MenuView"
  "views/FooterView"
	"utils/Router"
  "views/LogoView"
	"bootstrap"	

], (App, DataHandler, Translator, MenuView, FooterView, Router, LogoView) ->

	App.addRegions
    "menuRegion": "#menu-region"
    "mainRegion": "#main-region"
    "logoRegion": "#logo-region"
    "footerRegion": "#footer-region"

	App.addInitializer ->
    App.router = new Router()
    App.logoRegion.show new LogoView()
    App.menuRegion.show new MenuView()
    App.footerRegion.show new FooterView()

  App.on "initialize:after", ->
    Backbone.history?.start()

	App.bootstrap = ->
		$.when(
			App.request "user:loggedin"
			App.request "translator:load"
		).done ->
			App.start()

	App.vent.on "user:loggedin", ->
		App.router.controller.products()

	App.vent.on "user:loggedout", ->
		App.router.controller.root()

	App.vent.on "translator:locale:changed", ->
		App.menuRegion.currentView.render()
		App.mainRegion.currentView.render()
		App.footerRegion.currentView.render()

	App