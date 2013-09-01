express = require("express")
path = require("path")
mongoose = require("mongoose")
product = require("./models/product")
app = express()

# Database
# mongoose.connect "mongodb://localhost/ecomm_database"

# Config
app.configure ->
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static path.join(__dirname + "/../", "public")
  app.use express.errorHandler
    dumpExceptions: true
    showStack: true
  
# create rest endpoint for product model
# product.setup app
# 


# Launch server
app.listen process.env.PORT or 3000