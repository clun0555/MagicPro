express = require("express")
path = require("path")
mongoose = require("mongoose")
passport = require('passport')
resource  = require('express-resource-new')
expressMongoose = require('express-mongoose')
authentification = require("./controllers/authentification")
authorization = require("./config/authorization")
environment = require("./config/environment")
user = require('connect-roles')

app = express()

# Connect to MongoDB
mongoose.connect environment.MONGO_URL

console.log "connected to " + environment.MONGO_URL

# Create session store
sessionStore = environment.getSessionStore(express, mongoose)

# Config
app.configure ->
	app.use express.compress() # to allow gzip
	app.use express.static( path.join(__dirname + "/../", "public")) 
	app.use express.cookieParser()
	app.use express.bodyParser()

	app.use express.session
		secret: "test"
		collection: "sessions"
		cookie: { maxAge: 2 * 60 * 60 * 1000 } # 2 days	
		store: sessionStore	
	
	#authentification
	app.use passport.initialize()
	app.use passport.session()

	# authorization
	app.use(user)

	app.use express.methodOverride()
	
	app.use app.router
	
	app.set('controllers', __dirname + '/controllers');

	app.use express.errorHandler dumpExceptions: true, showStack: true

authorization.setup app
authentification.setup app

app.resource('products')
app.resource('users')
app.resource('categories')
app.resource('types')

app.post "/file/create", require("./controllers/files").create

# Launch server
app.listen environment.PORT

