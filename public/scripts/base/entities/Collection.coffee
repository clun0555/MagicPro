define [

	"backbone"
	"jquery"

], (Backbone, $) ->

	class Collection extends Backbone.Collection

		lookup: (id) ->
			job =  $.Deferred()
			
			if model = @get(id)
				job.resolve model
			else
				model = new @model identifier: id
				# model.set 
				model.fetch success: =>
					@add model
					job.resolve model

			return job
