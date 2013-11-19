###
	Main module. Called when dom is ready
	Responsable for initializing the Application.
	populating regions
	intializing data
###
define [
	"Base"
	"App"
	"utils/DataHandler"
	"utils/Translator"
	"utils/Authentification"
	"views/MenuView"
	"views/FooterView"	
	"views/LogoView"
	"controllers/ApplicationController"
	"controllers/AdminController"
	"controllers/ProductFinderController"
	"backbone.named.routes"
	"bootstrap"

], (Base, App, DataHandler, Translator, Authentification, MenuView, FooterView, LogoView, ApplicationController, AdminController, ProductFinderController) ->

	App.addRegions
		"menuRegion": "#menu-region"
		"mainRegion": "#main-region"
		"footerRegion": "#footer-region"
		"modalRegion": "#modal-region"
		"logoRegion": "#logo-region"

	App.addInitializer ->
		
		new ApplicationController region: App.mainRegion
		new AdminController region: App.mainRegion
		new ProductFinderController region: App.mainRegion

		App.showMenu()
		App.showFooter()
		App.showLogo()

	App.state = new Base.Model()

	App.showMenu = ->
		App.menuRegion.show new MenuView()

	App.showLogo = ->
		App.logoRegion.show new LogoView()	

	App.showFooter = ->
		App.footerRegion.show new FooterView()

	App.showModal = (view) ->
		@modalRegion.show view		
						
	App.on "initialize:after", ->
		Backbone.history?.start()
	
	App.bootstrap = ->
		
		$.when(
			App.request "user:loggedin"
			App.request "translator:load"
		).done -> 
			App.start()			

	App.vent.on "translator:locale:changed", ->	
		Backbone.history.stop()
		Backbone.history.start()
		App.menuRegion.currentView.render()
		App.footerRegion.currentView.render()
		# App.mainRegion.currentView.render()
		# App.modalRegion.currentView.render()


	App


