define [
	"Base"
	"App"
], (Base, App) ->
	
	class Product extends Base.Model

		urlRoot: "/api/products"

		relations: [			
			{
				type: "HasOne"
				key: 'type'
				relatedModel: 'Type'
				includeInJSON: "_id"
			},{
				type: "HasMany"
				key: 'designs'
				relatedModel: 'Design'
				includeInJSON: true
				collectionType: "BaseCollection"
				reverseRelation:
					key: 'product'
					includeInJSON: '_id'
			}
		]


		

