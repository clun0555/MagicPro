fs = require("fs")
knox = require("knox")
environment = require("../config/environment")
settings = require("../settings")
uuid = require("node-uuid")

exports.create = (req, res) ->

	client = knox.createClient
		key: environment.S3_KEY
		secret: environment.S3_SECRET
		bucket: environment.S3_BUCKET


	file = req.files.files[0]

	headers = 'Content-Length': file.size, 'Content-Type': file.type

	# stream = fs.createReadStream(file.path)
	fileId = uuid.v4() + require("path").extname(file.name)

	client.putFile file.path, "/" + fileId, headers,  (err, s3res) -> 
		if (err)
			res.status(500).send err
		else
			res.status(200).send(fileId)

		s3res.resume()
