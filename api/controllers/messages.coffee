_ = require("underscore")
user = require("connect-roles")
email = require("../utils/email")
environment = require("../config/environment")

module.exports = 

	options: 
		name: 'api/messages'
		id: 'message'
		
	
	create: (req, res) ->

		message = req.body

		email.send 
			from: message.email
			to: environment.EMAIL_FROM
			cc: null
			subject: "Contact"
			template: "message"
			data: 
				message: message

		res.send message		
		
				