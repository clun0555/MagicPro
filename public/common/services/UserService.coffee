define [
	"./services"	
], (services) ->	

	
	
	services.service "UserService", ($resource, $q, $http, $rootScope) ->

		generateForgotKey: (email) ->
			deferred = $q.defer()
			$resource("api/users/#{email}/forgot").get({}).$promise.then( 
			 	(user) ->
			 		deferred.resolve "ok"			 	
			 	->			
			 		deferred.reject()
			)

			deferred.promise

		findByForgotKey: (forgotKey) ->			
			deferred = $q.defer()
			$resource("api/users/:forgotKey/reset").get({ forgotKey: forgotKey }).$promise.then( 
			 	(user) ->
			 		deferred.resolve user			 	
			 	->			
			 		deferred.reject()
			)

			deferred.promise

		reset: (data) ->
			deferred = $q.defer()
			
			$resource("api/users/#{data.forgotKey}/reset").save(data).$promise.then( 
			 	(user) ->
			 		deferred.resolve user			 	
			 	->			
			 		deferred.reject()
			)

			deferred.promise


		
			





			







