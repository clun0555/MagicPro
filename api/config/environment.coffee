_ = require("underscore")
url = require("../utils/url")

config =

	PORT: process.env.PORT
	DOMAIN: process.env.DOMAIN
	
	S3_KEY: process.env.S3_KEY
	S3_SECRET: process.env.S3_SECRET
	S3_BUCKET: process.env.S3_BUCKET

	MONGO_URL: process.env.MONGO_URL or process.env.MONGOHQ_URL
	MONGO_LOGIN: process.env.MONGO_LOGIN
	MONGO_PASSWORD: process.env.MONGO_PASSWORD
	MONGO_HOSTNAME: process.env.MONGO_HOSTNAME
	MONGO_PORT: process.env.MONGO_PORT
	MONGO_DATABASE: process.env.MONGO_DATABASE

	REDIS_URL: process.env.REDIS_URL or process.env.REDISTOGO_URL
	REDIS_HOSTNAME: process.env.REDIS_HOSTNAME
	REDIS_DATABASE: process.env.REDIS_DATABASE
	REDIS_PASSWORD: process.env.REDIS_PASSWORD
	REDIS_PORT: process.env.REDIS_PORT

	IMAGE_SERVER_PATH: process.env.IMAGE_SERVER_PATH 

	SESSION_STORE: process.env.SESSION_STORE
	
	SMTP_HOST: process.env.SMTP_HOST
	SMTP_PORT: process.env.SMTP_PORT
	SMTP_LOGIN: process.env.SMTP_LOGIN
	SMTP_PASSWORD: process.env.SMTP_PASSWORD


	EMAIL_FROM: process.env.EMAIL_FROM
	EMAIL_CC: process.env.EMAIL_CC
	
# overide with local config if exists in config/local.coffee
try
	local = require("../../config/environment")
	config = _.extend config, local

# add default values
config = _.defaults config,
	PORT: 3000
	SESSION_STORE: "MONGO"
	DOMAIN: "http://localhost:" + config.PORT

## Process REDIS URL
path = url.process protocol: "redis", href: config.REDIS_URL, login: config.REDIS_DATABASE, password: config.REDIS_PASSWORD, hostname: config.REDIS_HOSTNAME, port: config.REDIS_PORT, slashes: true
config.REDIS_URL = path.href
config.REDIS_DATABASE = path.login
config.REDIS_PASSWORD = path.password
config.REDIS_HOSTNAME = path.hostname
config.REDIS_PORT = path.port

## Process MONGODB URL
path = url.process protocol: "mongodb", href: config.MONGO_URL, hostname: config.MONGO_HOSTNAME, password: config.MONGO_PASSWORD, port: config.MONGO_PORT, login: config.MONGO_LOGIN , pathname: config.MONGO_DATABASE, slashes: true
config.MONGO_URL = path.href
config.MONGO_LOGIN = path.login
config.MONGO_PASSWORD = path.password
config.MONGO_HOSTNAME = path.hostname
config.MONGO_PORT = path.port
config.MONGO_DATABASE = path.pathname

# returns a instance of session store depending on configuration
config.getSessionStore = (express, mongoose) ->
	switch config.SESSION_STORE
		when "MONGO"
			MongoStore = require('connect-mongo')(express)			
			new MongoStore db: mongoose.connection.db
		
		when "REDIS"
			RedisStore = require('connect-redis')(express)		
			# local redis needs no options
			options = if config.REDIS_HOSTNAME? then host: config.REDIS_HOSTNAME, port: config.REDIS_PORT, db: config.REDIS_DATABASE, pass: config.REDIS_PASSWORD else {}											
			new RedisStore options
		
		else
			new express.session.MemoryStore			


module.exports = config	



