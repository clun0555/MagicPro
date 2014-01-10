crypto = require("crypto")
environment = require("../config/environment")

exports.createS3Policy = (contentType, callback) ->
	date = new Date()
	s3Policy =
		expiration: "2014-12-01T12:00:00.000Z" # hard coded for testing
		conditions: [
			bucket: "magicpro"
			# ["starts-with", "$key", "uploads/"]
			# ["starts-with", "$Content-Type", contentType],
			acl: "public-read"		
			success_action_status: '201'
			['starts-with', '$key', '']
			# success_action_redirect: "http://localhost/"
		]

	
	# stringify and encode the policy
	stringPolicy = JSON.stringify(s3Policy)
	base64Policy = Buffer(stringPolicy, "utf-8").toString("base64")
	
	# sign the base64 encoded policy
	signature = crypto.createHmac("sha1", environment.S3_KEY).update(new Buffer(base64Policy, "utf-8")).digest("base64")
	
	# build the results object
	s3Credentials =
		s3Policy: base64Policy
		s3Signature: signature

	

	
	# send it back
	callback s3Credentials

	return