define [

	"base/entities/Model"
	"base/entities/Collection"
	"base/views/ItemView"
	"base/views/CollectionView"
	"base/config"

], (Model, Collection, ItemView, CollectionView) ->

	#entities
	Model: Model
	Collection: Collection

	#views
	ItemView: ItemView
	CollectionView: CollectionView