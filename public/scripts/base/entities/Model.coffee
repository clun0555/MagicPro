define [

	"backbone"
	"backbone.relational"

], (Backbone) ->

	class Model extends Backbone.Model
		idAttribute: "_id"		