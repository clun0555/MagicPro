define [
	"underscore"
	"Base"
	"models/Composition"
], (_, Base, Composition) ->
	
	class Bundle extends Base.Model	

		relations: [
			{
				type: "HasMany"
				key: 'compositions'
				relatedModel: 'Composition'
				includeInJSON: true
				collectionType: "BaseCollection"
			},{
				type: "HasOne"
				key: 'product'
				relatedModel: 'Product'
				includeInJSON: true	
			}
		]

		initialize: ( options ) ->
			super 
			
			@set 
				"product": options.product							

		updateComposition: (newComposition) ->

			for design in @get("product").get("designs").models
				
				newDesignComposition = _.findWhere newComposition, "designId": design.id
				designComposition = @getDesignComposition design.id
				quantity = newDesignComposition?.quantity
				
				if quantity
					unless designComposition?
						designComposition = new Composition design: design
						@get("compositions").add designComposition

					designComposition.set quantity: quantity 

				else if designComposition?
					@get("compositions").remove designComposition

				@set "quantity", @quantity()
				@set "price", @price()

		getDesignComposition: (designId) ->
			@get("compositions").find (composition) -> composition.get("design").id is designId

		# retrieves/calculate bundle quantity. If designId is specified will only return quantity for that design
		quantity: (designId) ->
			if designId?
				designComposition = @getDesignComposition designId
				designComposition?.get("quantity") ? 0
			else
				@get("compositions").reduce  ((memo, model) -> memo + model.get("quantity")), 0

		# retrieves/calculate bundle price. If designId is specified will only return price for that design
		price: (designId) ->
			@quantity(designId) * @get("product").get("price")



		
			





		

