mongoose = require('mongoose')
util = require("util")
crypto = require("crypto")
LocalStrategy = require("passport-local").Strategy
BadRequestError = require("passport-local").BadRequestError
options = saltlen: 32, iterations: 25000, keylen: 512, usernameField: "email"	
Cart = require("./cart")

User = new mongoose.Schema
	firstname: { type: String, required: true }
	lastname: { type: String, required: true }
	email: { type: String, required: true, unique: true }
	role: { type: String, required: true, default: "user" }
	status: { type: String, required: true, default: "pending" }
	cart: { type: mongoose.Schema.Types.Mixed }
	company: { type: String }
	abn: { type: String }
	phone: {type: String}
	mobile: {type: String}
	street: { type: String }
	suburb: { type: String }
	state: { type: String }
	postalcode: { type: String }
	hash: String
	salt: String
	forgot: String

User.methods.setPassword = (password, cb) ->
	return cb(new BadRequestError("user.password.required"))  unless password
	
	crypto.randomBytes options.saltlen, (err, buf) =>
		return cb(err)  if err
		salt = buf.toString("hex")
		crypto.pbkdf2 password, salt, options.iterations, options.keylen, (err, hashRaw) =>
			return cb(err)  if err
			@set "hash", new Buffer(hashRaw, "binary").toString("hex")
			@set "salt", salt
			cb null, this

User.methods.authenticate = (password, cb) ->
	
	crypto.pbkdf2 password, @get("salt"), options.iterations, options.keylen, (err, hashRaw) =>
		return cb(err)  if err
		hash = new Buffer(hashRaw, "binary").toString("hex")
		if hash is @get("hash")
			cb null, this
		else
			cb null, false, message: "user.password.incorect"

User.methods.generateForgotKey = (cb) ->
	crypto.randomBytes 32, (ex, buf)  =>
		key = buf.toString('hex')
		@set "forgot", key
		cb(key)

User.methods.toJSON = ->
	# remove salt and hash from object
	user = this.toObject()
	delete user.salt
	delete user.hash
	return user

User.statics.authenticate = ->
	(username, password, cb) =>
		@findByUsername username, (err, user) ->
			return cb(err)  if err
			if user
				user.authenticate password, cb
			else
				cb null, false, message: "user.username.incorrect"

User.statics.serializeUser = ->
	(user, cb) -> cb null, user.get(options.usernameField)

User.statics.deserializeUser = ->	
	(username, cb) => @findByUsername username, cb

User.statics.register = (user, password, cb) ->
	# Create an instance of this in case user isn't already an instance
	user = new this(user) unless user instanceof this
	return cb(new BadRequestError("user.username.required"))  unless user.get(options.usernameField)
	
	@findByUsername user.get(options.usernameField), (err, existingUser) ->
		return cb(err)  if err
		return cb(new BadRequestError("user.username.existing")) if existingUser
		user.setPassword password, (err, user) ->
			return cb(err)  if err
			user.save (err) ->
				return cb(err)  if err
				cb null, user	

User.statics.findByUsername = (username, cb) ->
	queryParameters = {}
	queryParameters[options.usernameField] = username
	query = @findOne(queryParameters)
	query.exec cb



module.exports = mongoose.model 'User', User