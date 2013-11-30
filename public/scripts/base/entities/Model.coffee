define [
	"underscore"
	"jquery"
	"backbone"
	"backbone.relational"

], (_, $, Backbone) ->

	Backbone.RelationalModel.findWhere = (attributes) ->
		Backbone.Relational.store.getCollection(this).findWhere(attributes)

	class Model extends Backbone.RelationalModel
		idAttribute: "_id"

		parse: (response, options) ->
			# when fetching by other fileds than id, an array is returned 
			# return first element if single element array
			if _.isArray(response) and response.length is 1 then response[0] else response

		fetchWhere: (attributes, options = {}) ->
			options.data = attributes
			@fetch options

		# @findWhere: (attributes) ->
			


