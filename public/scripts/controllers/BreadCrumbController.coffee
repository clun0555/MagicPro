define [
	"Base"
	"App"
	"views/BreadCrumbView"	
], (Base, App, BreadCrumbView) ->

	class BreadCrumbController extends Base.Controller

		states: 
			"product:show:categories": "showCategories"
			"product:show:types": "showTypes"
			"product:show:products": "showProducts"
			"product:show:product": "showProduct"

		authorize: (action, args) -> @isLoggedIn()

		showCategories: ->
			@title "Home" # TODO use translation
			@show new BreadCrumbView model: new Base.Model()

		showTypes: (categoryIdentifier) ->
			@do [
				App.request "category:by:identifier", categoryIdentifier
			], (category) ->
				@title category.get("title")
				@show new BreadCrumbView model: new Base.Model(category: category.toJSON())

		showProducts: (categoryIdentifier, typeIdentifier) ->
			@do [
				App.request "category:by:identifier", categoryIdentifier
				App.request "type:by:identifier", typeIdentifier
			], (category, type) ->
				@title type.get("title")
				@show new BreadCrumbView model: new Base.Model(category: category.toJSON(), type: type.toJSON())


		showProduct: (categoryIdentifier, typeIdentifier, productIdentifier) ->
			@do [
				App.request "category:by:identifier", categoryIdentifier
				App.request "type:by:identifier", typeIdentifier
				App.request "product:by:identifier", productIdentifier
			], (category, type, product) ->
				@title product.get("title")
				@show new BreadCrumbView model: new Base.Model(category: category.toJSON(), type: type.toJSON(), product: product.toJSON())




