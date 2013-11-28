define [
	"Base"
	"App"
], (Base, App) ->
	
	class Product extends Base.Model

		urlRoot: "/api/products"
		idAttribute: "identifier"			


		

