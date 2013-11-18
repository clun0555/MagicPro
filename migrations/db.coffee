mongoose = require("mongoose")

mongoose.connect(process.env.MONGOHQ_URL or "mongodb://localhost/ecomm_database")


