define [
	"./services"
	"q"
], (services, Q) ->	

	# this is a draft version of the coming AuthentificationService
	# pushed like this to meet the deam deas line :)

	services.provider "AuthentificationService",  ->

		### Private ###
		name = "Default"
		loginInitializers = []

		runIntializers = ->
			jobs = (job() for job in loginInitializers)
			Q.all(jobs)

		### Public Configurator ###

		@setName = (n) -> name = n

		
		### API ###

		@$get = ->
			
			greet: ->
				message = "Hello #{name}"
				console.log message
				message

			login: (data) ->
				# do login logic
				return runIntializers()

			addLoginInitializer: (cb) ->
				loginInitializers.push cb


		return





			





			







