###
loads sub modules and wraps them up into the main module
this should be used for top-level module definitions only
###
define [
	"angular"
	"angular-route"
	"angular-resource"
	"angular-cookies"
	"angular-ui-router"
	"angular-translate"
	"angular-translate-storage-cookie"
	"bootstrap-dropdown"
	
	"common/controllers/index"
	"common/directives/index"
	"common/services/index"	
	"views/views"


	"app/shop/index"
	"app/admin/index"
], (angular) ->
	
	angular.module("app", [
		"ngRoute"
		"ngResource"
		"ngCookies"
		"ui.router"
		'pascalprecht.translate'

		"app.controllers"
		"app.directives"		
		"app.services"
		"app.shop"
		"app.admin"

		"templates.app"

	]).value('$anchorScroll', angular.noop) # prevents routes to scroll at the top
