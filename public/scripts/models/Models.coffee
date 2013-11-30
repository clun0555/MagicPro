require [
	"backbone"
	"Base"	
	"models/Product"
	"models/Design"
	"models/Cart"
	"models/Bundle"
	"models/Composition"
	"models/Category"
	"models/Type"
	"models/User"
], (Backbone, Base) ->
	
	Base.Models = {}
	# add all models
	Base.Models[Model.name] = Model for Model in arguments when Model not in [ Base, Backbone ]
	
	# add a the base colleciton
	Base.Models.BaseCollection = Base.Collection
	
	Backbone.Relational.store.removeModelScope window
	
	Backbone.Relational.store.addModelScope Base.Models
	
