define [
	"./services"	
], (services) ->	

	
	
	services.service "UserService", ($resource, $q, $http, $rootScope, SessionService) ->

		Users = $resource "/api/users/:id", { "_id": "@id"}, { 'update': {method:'PUT'} }

		save: (user) ->
			if user._id?
				Users.update( { id: user._id }, user).$promise
			else
				Users.save( { }, user).$promise


		find: (userId) ->
			$resource("api/users/:id").get({ id: userId }).$promise

		remove: (user) ->
			if SessionService.user()._id is user
				$q.defer().reject() 
			else
				Users.remove({ id: user._id }, user).$promise

		findAll: (query) ->
			if query?
				$resource("api/users?advanced=#{JSON.stringify(query)}").query().$promise
			else
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
			
			$resource("api/users/#{data.forgotKey ? data.email}/reset").save(data).$promise.then( 
				(user) -> 
					deferred.resolve user			 	
				(xhr) -> 
					deferred.reject { code: xhr.status, message: xhr.data }			 	
			)

			deferred.promise


		
			





			







