Q = require("q")
mongoose = require("mongoose")
s3 = require("../utils/s3")

module.exports = exports = (schema, options) ->
	for field in options.fields 
		do (schema, options, field) ->
			definition = {}
			
			# definition[field] = {
			# 	path: String
			# 	type: String
			# 	width: Number
			# 	height: Number
			# }

			definition[field] = {
				type: mongoose.Schema.Types.Mixed
			}			

			schema.add definition


	schema.methods.isDraft = (field) ->
		@[field]?.path.indexOf("draft/") == 0

	schema.methods.getPreviousFile = (field) ->
		@["_"+field]

	schema.methods.removePreviousFile = (field) ->
		
		if @getPreviousFile(field)?
			# remove if previous file exists
			s3.removeFile(@getPreviousFile(field).path)
		else
			# otherwise do nothing
			defer = Q.defer()
			defer.resolve()
			defer.promise
			

	schema.methods.syncFile = (field) ->

		deferred = Q.defer()

		# file is defined
		if @[field]?

			# file is not a draft do nothing
			return deferred.resolve() unless @isDraft(field)
			
			# file is a draft, publish...
			s3.publishFile(@[field].path).then (newPath) =>
				@[field].path = newPath

				# and remove previous file
				@removePreviousFile(field).then -> deferred.resolve()
		
		else
			# file isnt defined, remove previous file
			@removePreviousFile(field).then -> deferred.resolve()
				
		
		deferred.promise

	schema.post 'init', (doc) ->
		for field in options.fields
			doc["_" + field] = doc[field]


	schema.pre 'save', (next) ->
		console.log "save"
		publishJobs = (@syncFile(field) for field in options.fields)

		Q.all(publishJobs).then -> next()

	schema.pre 'remove', (next) ->
		jobs = (@removePreviousFile(field) for field in options.fields)
		
		Q.all(jobs).then -> next()	

