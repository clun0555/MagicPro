###
	Main module. Called when dom is ready
	Responsable for initializing the Application.
	populating regions
	intializing data
###
define [
	
	"App"
	"utils/DataHandler"
	"views/MenuView"
	"utils/Router"
  "views/LogoView"
	"bootstrap"	

], (App, DataHandler, MenuView, Router, LogoView) ->

	App.addRegions
    "menuRegion": "#menu-region"
    "mainRegion": "#main-region"
    "logoRegion": "#logo-region"

	App.addInitializer ->
    App.router = new Router()
    App.logoRegion.show new LogoView()
    App.menuRegion.show new MenuView()

  App.on "initialize:after", ->
		Backbone.history?.start()
	
	App.bootstrap = ->
		App.request("user:loggedin").always -> App.start()

	App.vent.on "user:loggedin", ->
		App.router.controller.products()

	App.vent.on "user:loggedout", ->
		App.router.controller.root()

	App