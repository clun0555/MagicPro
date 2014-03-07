define [
	"./services"	
], (services) ->	

	rules = 
		loggedIn: (user) ->
			user?

		admin: (user) ->
			user.role is "admin" and user.status is "validated"

		validated: (user) ->
			user?.status is "validated"
	
	services.service "SessionService", ($resource, $q, $http, $rootScope, AuthentificationService) ->

		login: (email, password) ->
			
			deferred = $q.defer()

			Session = $resource("/api/authentification/login")
			
			user = Session.save {},  { username: email, password: password }, 
				=>	
					@session = { user: user }
					$rootScope.user = @user()
					AuthentificationService.login({}).then =>
						$rootScope.$broadcast("user:changed")
						deferred.resolve()
						
				(xhr) => 
					@session = null
					deferred.reject { code: xhr.status, message: xhr.data }

			deferred.promise

		register: (user) ->

			deferred = $q.defer()

			Session = $resource("/api/authentification/register")
			
			user = Session.save {},  user,  
				=>	
					@session = { user: user }
					$rootScope.user = @user()
					deferred.resolve()
				=> 
					@session = null
					deferred.reject()					

			deferred.promise

		get: -> @session

		user: -> @session?.user

		logout: ->
			deferred = $q.defer()

			$http(method: 'GET', url: '/api/authentification/logout' )
				.success (data) =>
					@session = false
					$rootScope.user = @user()
					$rootScope.$broadcast("user:changed")
					deferred.resolve()
				.error (data) =>
					@session = false
					$rootScope.user = @user()
					$rootScope.$broadcast("user:changed")
					deferred.resolve()					

			deferred.promise
		
		
		fetchSession: ->
			deferred = $q.defer()

			if @session
				# session is alredy active on client return.				
				deferred.resolve() # TODO check expire date
			else
				$http( method: 'GET', url: '/api/authentification/currentuser' )
					.success (data) =>
						@session = user: data
						$rootScope.user = @user()
						$rootScope.$broadcast("user:changed")
						deferred.resolve()
					.error (data) =>
						@session = false
						deferred.reject code: 403				

			deferred.promise

		security: (rule) ->
			checker = if typeof rule is 'string' then rules[rule] else rule				
			checker(@user())
			


		getUserKey: ->
			@user()?._id ? "guest"

		getStoreKey: (dataKey) ->
			@getUserKey() + "-" + dataKey

		# keeps in browser memory some data for a specific user. Data will not survive logout
		keep: (key, data) ->
			@get()[key] = data

		# store data in localstorage for that user
		storeLocal: (dataKey, data) ->
			localStorage.setItem(@getStoreKey(dataKey), JSON.stringify(data))
			
		# retrieve data from local storage for the current user
		retrieveLocal: (dataKey) ->
			jsonData = localStorage.getItem(@getStoreKey(dataKey))
			if jsonData then JSON.parse(jsonData) else null

		# checks if some data was stored for that user in localstorage
		hasLocal: (dataKey) ->
			retrieveLocal(dataKey)?

		isLoggedIn: ->
			@user()?

		isAuthentificated: ->
			@session? and @session isnt false

		isSessionFetched: ->
			# session isnt null/undefined or explicitily false
			@session? or @session is false

			





			







