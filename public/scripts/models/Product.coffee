define [
	"Base"
], (Base) ->
	
	class Product extends Base.Model

		urlRoot: "/api/products"
		idAttribute: "identifier"

		

