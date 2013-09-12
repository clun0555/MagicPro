express = require("express")
path = require("path")
mongoose = require("mongoose")
product = require("./models/product")
type = require("./models/type")
category = require("./models/category")
userControler = require("./controllers/userController")
app = express()
passport = require('passport')
LocalStrategy = require('passport-local').Strategy

# Database
mongoose.connect process.env.MONGOHQ_URL or "mongodb://localhost/ecomm_database"

# Config
app.configure ->
	app.use express.static path.join(__dirname + "/../", "public")
	app.use express.cookieParser()
	app.use express.bodyParser()
	app.use express.session(secret: 'keyboard cat')
	app.use passport.initialize()
	app.use passport.session()
	app.use express.methodOverride()
	app.use app.router
	
	app.use express.errorHandler
		dumpExceptions: true
		showStack: true


User = require('./models/user')
passport.use new LocalStrategy(User.authenticate())
passport.serializeUser User.serializeUser()
passport.deserializeUser User.deserializeUser()

ensureAuthenticated = (req, res, next) ->
	if req.isAuthenticated() then next() else res.status(401).send("Unauthorized")

publicRoutes = ["/", "/api/login", "/api/register"]
app.all "*", (req, res, next) ->
	if req.url in publicRoutes then next() else ensureAuthenticated(req, res, next)
		
# create rest endpoint for product model
product.setup app
# create rest endpoint for category model
category.setup app
# create rest endpoint for type model
type.setup app
# create rest endpoint for user model
userControler.setup app

# Launch server
app.listen process.env.PORT or 3000