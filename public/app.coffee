###
loads sub modules and wraps them up into the main module
this should be used for top-level module definitions only
###
define [
	"angular"
	"angular-animate"
	"angular-bootstrap"
	"angular-route"
	"angular-resource"
	"angular-cookies"
	"angular-ui-router"
	"angular-translate"
	"angular-translate-storage-cookie"
	"angular-translate-interpolation-messageformat"
	"angular-bindonce"	

	"fastclick"

	"angular-file-upload"
	# "angular-mocks"

	"common/controllers/index"
	"common/directives/index"
	"common/services/index"
	"views/views"
	"ng-infinite-scroll"

	"app/shop/index"
	"app/admin/index"
	"app/blog/index"
	"app/contact/index"

], (angular) ->
	
	angular.module("app", [
		
		# vendor dependencies
		"ngRoute"
		'ngAnimate'
		'ui.bootstrap'
		"ngResource"
		"ngCookies"
		"ui.router"
		'pascalprecht.translate'

		'angularFileUpload'
		'infinite-scroll'
		"pasvaz.bindonce"

		# common dependencies
		"app.controllers"
		"app.directives"
		"app.services"
		# "ngMock"

		# featues dependencies
		"app.shop"
		"app.admin"
		"app.blog"
		"app.contact"

		# all templates
		"templates.app"

	])
	# .value('$anchorScroll', angular.noop) # prevents routes to scroll at the top
