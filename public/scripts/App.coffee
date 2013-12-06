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
	
	"controllers/index"
	"directives/index"
	# "filters/index"
	"services/index"
], (angular) ->
	
	angular.module "app", [
		"app.controllers"
		"app.directives"
		# "app.filters"
		"app.services"
		"ngRoute"
		"ngResource"
		"ngCookies"
		"ui.router"
		'pascalprecht.translate'		
	]
