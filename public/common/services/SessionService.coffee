define [
	"./services"	
], (services) ->	

	rules = 
		loggedIn: (session) ->
			session?

		admin: (session) ->
			session.role is "admin"
	
	services.service "SessionService", ($resource, $q, $http, $rootScope) ->

		$rootScope.hello = "world"

		login: (email, password) ->
			
			deferred = $q.defer()

			Session = $resource("/api/authentification/login")
			
			@session = Session.save {},  { username: email, password: password }, 
				=>	
					$rootScope.user = @session
					deferred.resolve()
				=> 
					@session = null
					deferred.reject()					

			deferred.promise

		get: ->
			@session

		logout: ->
			deferred = $q.defer()

			$http(method: 'GET', url: '/api/authentification/logout' )
				.success (data) =>
					@session = null
					$rootScope.user = @session
					deferred.resolve()
				.error (data) =>
					@session = null
					$rootScope.user = @session
					deferred.resolve()
					# deferred.reject code: 500

			deferred.promise
		
		
		fetchSession: ->
			deferred = $q.defer()

			if @session
				# session is alredy active on client return.				
				deferred.resolve() # TODO check expire date
			else
				$http(method: 'GET', url: '/api/authentification/currentuser' )
					.success (data) =>
						@session = data
						$rootScope.user = @session					
						deferred.resolve()
					.error (data) =>
						@session = null
						deferred.reject code: 403				

			deferred.promise

		security: (rule) ->
			rules[rule](@session)





			







