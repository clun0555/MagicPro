define [

	"backbone"
	"jquery"

], (Backbone, $) ->

	class Collection extends Backbone.Collection

		lookup: (attributes) ->
			job =  $.Deferred()
			
			if model = @findWhere(attributes)
				job.resolve model
			else
				model = new @model attributes
				# model.set 
				model.fetchWhere attributes, success: =>
					@add model
					job.resolve model

			return job
