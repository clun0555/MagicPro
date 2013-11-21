define [
	"Base"
], (Base) ->
	
	class Category extends Base.Model

		urlRoot: "/api/categories"
		idAttribute: "identifier"

		

