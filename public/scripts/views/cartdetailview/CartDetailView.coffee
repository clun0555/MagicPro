define [
	"App"
	"Base"
	"templates/cartdetailview/cart_detail"
], (App, Base, template) ->

	class CartDetailView extends Base.ItemView
		
		template: template

		className: "cart-detail"

		events: 
			"click .submit-cart": "submitCart"
			"click .home": "home"

		serializeData: ->
			data = super()

			data.saved = @saved
			
			# composition.design returns its i
			for jsonBundle in data.bundles
				bundle = @model.getBundle(jsonBundle.product._id)
				for jsonComposition in jsonBundle.compositions
					design = bundle.get("product").get("designs").get jsonComposition.design
					jsonComposition.design = design.toJSON()

			data

		submitCart: ->
			App.request "cart:save", =>
				@saved = true
				@render()
			
		home: ->
			App.navigate "app:root"
