define [
	"underscore"
	"Base"
], (_, Base) ->
	
	class Bundle extends Base.Model		

		initialize: (options) ->
			@composition = new Base.Collection()
			{ @product } = options
			
			@set 
				"itemId": @product.get("_id")
				"title": @product.get("title")
				"productIdentifier": @product.get("identifier")
				"categoryIdentifier": @product.get("categoryIdentifier")
				"typeIdentifier": @product.get("typeIdentifier")


		updateComposition: (newComposition) ->

			for design in @product.get("designs")
				
				newDesignComposition = _.findWhere newComposition, "designId": design.designId
				designComposition = @getDesignComposition design.designId
				count = newDesignComposition?.count
				
				if count
					unless designComposition?
						designComposition = new Base.Model designId: design.designId
						@composition.add designComposition

					designComposition.set count: count 

				else if designComposition?
					@composition.remove designComposition

				@set "quantity", @quantity()
				@set "price", @price()

		getDesignComposition: (designId) ->
			@composition.findWhere "designId": designId

		# retrieves/calculate bundle quantity. If designId is specified will only return quantity for that design
		quantity: (designId) ->
			if designId?
				designComposition = @getDesignComposition designId
				designComposition?.get("count") ? 0
			else
				@composition.reduce  ((memo, model) -> memo + model.get("count")), 0

		# retrieves/calculate bundle price. If designId is specified will only return price for that design
		price: (designId) ->
			@quantity(designId) * @product.get("price")



		
			





		

