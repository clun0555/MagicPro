require('newrelic')
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
		cookie: { maxAge: 2 * 24 * 60 * 60 * 1000 } # 2 days
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
app.resource('carts')
app.resource('articles')
app.resource('messages')


app.get "/api/users/:email/forgot", require("./controllers/users").forgot
app.get "/api/users/:forgotKey/reset", require("./controllers/users").userByForgotKey
app.post "/api/users/:forgotKey/reset", require("./controllers/users").reset


# redirect anything else to index.html to allow html5 routes
app.all "/*", (req, res, next) -> res.sendfile( 'index.html', { root: ( __dirname + "/../public/" ) } )

# Launch server
app.listen environment.PORT


