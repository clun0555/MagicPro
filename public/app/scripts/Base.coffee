define [

	"base/entities/Model"
	"base/entities/Collection"
	"base/views/ItemView"
	"base/views/CollectionView"
	"base/views/CompositeView"
	"base/views/Layout"
	"base/config"

], (Model, Collection, ItemView, CollectionView, CompositeView, Layout) ->

	#entities
	Model: Model
	Collection: Collection

	#views
	ItemView: ItemView
	CollectionView: CollectionView
	CompositeView: CompositeView
	Layout: Layout