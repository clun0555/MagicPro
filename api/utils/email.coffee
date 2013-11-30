
nodemailer = require("nodemailer")

smtpTransport = nodemailer.createTransport "SMTP",
	service: "Mandrill"
	auth:
		user: "investmytalent@gmail.com"
		pass: "RyawNA2fVGJrgJE2ndBLyw"


exports.send = (options) ->

	smtpTransport.sendMail options, (error, response) ->
		if(error)
			console.log(error)
		else
			console.log("Message sent: " + response.message)
	

