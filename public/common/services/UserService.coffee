define [
	"./services"	
], (services) ->	

	
	
	services.service "UserService", ($resource, $q, $http, $rootScope) ->

		Users = $resource "/api/users/:id", { "_id": "@id"}, { 'update': {method:'PUT'} }

		save: (user) ->
			Users.update( { id: user._id }, user).$promise


		find: (userId) ->
			$resource("api/users/:id").get({ id: userId }).$promise

		findAll: ->
			$resource("api/users").query().$promise

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


		
			





			







