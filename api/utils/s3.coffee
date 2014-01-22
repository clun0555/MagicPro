crypto = require("crypto")
environment = require("../config/environment")
knox = require("knox")
Q = require("q")

	
client = knox.createClient
	key: environment.S3_KEY
	secret: environment.S3_SECRET
	bucket: environment.S3_BUCKET

exports.removeFile = (path) ->
	deferred = Q.defer()
	
	client.deleteFile path, ->
		deferred.resolve()

	deferred.promise

# copy file from /draft/file to /file
exports.publishFile = (draftImageId) ->
	deferred = Q.defer()
	
	publishedImageId = draftImageId.substr(6, draftImageId.length)

	client
		.copy(draftImageId, publishedImageId)
		.on 'response', (rs2) ->
			deferred.resolve(publishedImageId)
		.end()

	deferred.promise


exports.publishFiles = (drafts) ->

	publishJobs = @publishFile draft for draft in drafts

	Q.all publishJobs


