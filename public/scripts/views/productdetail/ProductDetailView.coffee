define [
	"underscore"
	"Base"
	"App"
	"views/productdetail/ProductDetailBundleSummary"
	"templates/productdetail/product_detail_view"

], (_, Base, App, ProductDetailBundleSummary, template) ->

	class ProductDetailView extends Base.Layout

		className: "product-detail-view container"
		template: template

		regions: 
			"summary": ".bundle-summary-region"

		events: 
			"keyup .design-count input": "updateCart"

		initialize: (options) ->
			super options
			{ @cart } = options


		updateCart: ->
			vals = _.chain(@$(".design-count input")).map((e) -> count: parseInt($(e).val(), 10), designId: $(e).data("design")).compact().value()
			@cart.updateBundle @model, vals


		onRender: ->
			@summary.show new ProductDetailBundleSummary product: @model, cart: @cart

		serializeData: ->
			data = super()
			data.quantity = (designId) =>
				@cart.quantity @model, designId
			data
