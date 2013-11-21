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


		updateCart: ->
			vals = _.chain(@$(".design-count input")).map((e) -> count: parseInt($(e).val(), 10), designId: $(e).data("design")).compact().value()
			App.state.cart.updateBundle @model, vals


		onRender: ->
			@summary.show new ProductDetailBundleSummary product: @model

		serializeData: ->
			data = super()
			data.quantity = (designId) =>
				App.state.cart.quantity @model, designId
			data
