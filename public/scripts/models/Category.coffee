define [
	"Base"
	"backbone"
], (Base, Backbone) ->
	
	class Category extends Base.Model

		urlRoot: "/api/categories"		

		relations: [
			type: "HasMany"
			key: 'types'
			relatedModel: 'Type'
			includeInJSON: true
			collectionType: "BaseCollection"
			reverseRelation:
				key: 'category'
				includeInJSON: '_id'
		]

		

