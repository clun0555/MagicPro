###
	This is a sample file for running localy.
	
	to set environement variables when deployed, use environement variables.
	heroku config:set S3_KEY="<myS3Key>" S3_SECRET="<myS3Secret>" S3_BUCKET="<myS3Bucket>" IMAGE_SERVER_PATH="<pathToImageServer>"  --app <appName>
###


module.exports =
	
	# running port. Defaults to 3000
	PORT: "4000"

	# DOMAIN  -  used to generate absolute links in emails / social media ... (defaults to 'http://localhost:<PORT>' is not set)
	# DOMAIN: "http://magicpro.herokuapp.com" 

	# S3 credentials 
	S3_KEY: "AKIAIHAIMDM6LGXYHWUA"
	S3_SECRET: "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"
	S3_BUCKET: "magicpro"

	##### MongoDB
	## path to mongo database
	MONGO_URL: "mongodb://localhost/magicpro"
	## or
	# MONGO_HOSTNAME: "localhost"
	# MONGO_DATABASE: "/projecttemplate"
	# MONGO_PORT: ""
	# MONGO_PASSWORD: ""

	##### REDIS 
	## path to redis database
	# REDIS_URL: "redis://redistogo:85690a983649bcc0daba5a44a80e4eba@grideye.redistogo.com:9098/"
	## or
	# REDIS_HOSTNAME: ""
	# REDIS_PORT: ""
	# REDIS_DATABASE: ""
	# REDIS_PASSWORD: ""

	##### image server
	IMAGE_SERVER_PATH: "http://image-resizer-magicpro.herokuapp.com"

	##### session store MONGO|REDIS|MEMORY. Defaults to "MONGO"
	# SESSION_STORE: "MONGO"

	# used by grunt for manual deployement
	HEROKU_APP: "magicpro"

	SMTP_HOST: "smtp.mandrillapp.com"
	SMTP_PORT: "587"
	SMTP_LOGIN: "investmytalent@gmail.com"
	SMTP_PASSWORD: "RyawNA2fVGJrgJE2ndBLyw"

	EMAIL_FROM: "investmytalent@gmail.com"
	EMAIL_CC: "investmytalent@gmail.com"

