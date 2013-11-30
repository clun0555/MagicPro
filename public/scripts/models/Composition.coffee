define [
	"underscore"
	"Base"
], (_, Base) ->
	
	class Composition extends Base.Model	
		relations: [
			{
				type: "HasOne"
				key: 'design'
				relatedModel: 'Design'
				includeInJSON: "_id"							
			}
		]