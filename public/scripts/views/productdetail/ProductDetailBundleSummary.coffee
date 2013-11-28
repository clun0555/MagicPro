define [
	"underscore"
	"Base"
	"App"
	"templates/productdetail/product_detail_bundle_summary"

], (_, Base, App, template) ->

	class ProductDetailBundleSummary extends Base.ItemView

		className: "product-detail-bundle-summary"
		template: template

		modelEvents: 
			"change": "render"

		initialize: (options) ->
			{ @product, @cart } = options
			@model = new Base.Model()
			@listenTo @cart, "updated", @updateSummary
			@updateSummary()

		updateSummary: ->
			bundle = @cart.getBundle(@product)	
			price = if bundle? then bundle.get("price") else 0
			quantity = if bundle? then bundle.get("quantity") else 0
			@model.set "totalPrice": price, "totalQuantity": quantity 

