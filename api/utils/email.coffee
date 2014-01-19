
nodemailer = require("nodemailer")
_ = require("underscore")
environment = require("../config/environment")
settings = require("../settings")
q = require("q")
path = require('path')
emailTemplates = require('email-templates')

emailTemplateDir = path.join(settings.home, "templates/email/")

smtpTransport = nodemailer.createTransport "SMTP",
	host: environment.SMTP_HOST
	port: environment.SMTP_PORT
	auth:
		user: environment.SMTP_LOGIN
		pass: environment.SMTP_PASSWORD

resolveTemplate = (options) ->

	defer = q.defer()
	
	if options.text
		defer.resolve(options.text)

	else if options.template?

		emailTemplates emailTemplateDir, (err, render) ->

			return defer.reject(err) if err?

			data = options.data ? {}
			data.subject = options.subject

			data.helpers =
				currency: (n) -> "$" + n.toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,')				

			
			render options.template, data, (err, html, text) ->
				if err
					defer.reject err
				else
					defer.resolve html

	else
		defer.reject()

	defer.promise

	


exports.send = (options) ->

	options = _.defaults options, 
		from: environment.EMAIL_FROM
		cc: environment.EMAIL_CC

	resolveTemplate(options).then (html) ->
		options.html = html

		smtpTransport.sendMail options, (error, response) ->
			if(error)
				console.log(error)
			else
				console.log("Message sent: " + response.message)





	

