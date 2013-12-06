define [
	"./module"	
], (services) ->	
	
	services.service "SessionService", ($resource, $q) ->

		login: (email, password) ->
			
			deferred = $q.defer()

			Session = $resource("/api/authentification/login")
			
			Session.save {},  { username: email, password: password }, 
				->
					deferred.resolve()
				-> 
					deferred.reject()					

			deferred.promise
		
		

			







