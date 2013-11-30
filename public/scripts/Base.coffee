define [

	"base/entities/Model"
	"base/entities/Collection"
	"base/views/ItemView"
	"base/views/CollectionView"
	"base/views/Layout"
	"base/views/CompositeView"
	"base/utils/Router"
	"base/utils/Controller"
	"base/utils/State"
	"base/config"

], (Model, Collection, ItemView, CollectionView, Layout, CompositeView,  Router, Controller, State) ->

	#entities
	Model: Model
	Collection: Collection

	#views
	ItemView: ItemView
	CollectionView: CollectionView
	Layout: Layout
	CompositeView: CompositeView

	Router: Router
	Controller: Controller
	State: State

	Models: {}