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

		showTypes: (categorySlug) ->
			@do [
				App.request "category:by:slug", categorySlug
			], (category) ->
				@title category.get("title")
				@show new BreadCrumbView model: new Base.Model(category: category.toJSON())

		showProducts: (categorySlug, typeSlug) ->
			@do [
				App.request "category:by:slug", categorySlug
				App.request "type:by:slug", typeSlug
			], (category, type) ->
				@title type.get("title")
				@show new BreadCrumbView model: new Base.Model(category: category.toJSON(), type: type.toJSON())


		showProduct: (categorySlug, typeSlug, productSlug) ->
			@do [
				App.request "category:by:slug", categorySlug
				App.request "type:by:slug", typeSlug
				App.request "product:by:slug", productSlug
			], (category, type, product) ->
				@title product.get("title")
				@show new BreadCrumbView model: new Base.Model(category: category.toJSON(), type: type.toJSON(), product: product.toJSON())




