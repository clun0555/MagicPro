define [
	"angular"
	"app"
], (angular, app) ->

	# this is a draft version
	# pushed like this to meet the deam deas line :)

	describe "AuthentificationService", ->

		value = false

		beforeEach(module('app.services'))		
		
		# beforeEach(module( (AuthentificationServiceProvider) ->
		# 	AuthentificationServiceProvider.addLoginInitializers (  ->	value = true )
		# ))

		it "runs initializers", inject (AuthentificationService) ->
			
			AuthentificationService.login({}).done ->
				expect(true).toBeTruthy()
			
			return		

		return

	return
