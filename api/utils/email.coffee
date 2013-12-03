
nodemailer = require("nodemailer")
_ = require("underscore")
environment = require("../config/environment")

smtpTransport = nodemailer.createTransport "SMTP",
	host: environment.SMTP_HOST
	port: environment.SMTP_PORT
	auth:
		user: environment.SMTP_LOGIN
		pass: environment.SMTP_PASSWORD


exports.send = (options) ->

	options = _.defaults options, 
		from: environment.EMAIL_FROM
		cc: environment.EMAIL_CC


	smtpTransport.sendMail options, (error, response) ->
		if(error)
			console.log(error)
		else
			console.log("Message sent: " + response.message)
	

