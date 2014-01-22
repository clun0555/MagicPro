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


exports.createS3Policy = (callback) ->
	date = new Date()
	s3Policy =
		expiration: "2014-12-01T12:00:00.000Z" # hard coded for testing
		conditions: [
			{ bucket: environment.S3_BUCKET }
			# ["starts-with", "$key", "uploads/"]
			["starts-with", "$Content-Type", ""],
			{ acl: "public-read" }
			{ success_action_status: '201' }
			['starts-with', '$key', '']
			# success_action_redirect: "http://localhost/"
		]

	
	# stringify and encode the policy
	stringPolicy = JSON.stringify(s3Policy)
	base64Policy = Buffer(stringPolicy, "utf-8").toString("base64")
	
	# sign the base64 encoded policy
	signature = crypto.createHmac("sha1", environment.S3_SECRET).update(new Buffer(base64Policy, "utf-8")).digest("base64")
	
	# build the results object
	s3Credentials =
		s3Policy: base64Policy
		s3Signature: signature

	# send it back
	callback s3Credentials

	return