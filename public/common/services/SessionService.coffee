define [
	"./services"	
], (services) ->	

	rules = 
		loggedIn: (user) ->
			user?

		admin: (user) ->
			user.role is "admin"

		buyer: (user) ->
			user?.role? and user.role in [ "buyer", "admin" ]
	
	services.service "SessionService", ($resource, $q, $http, $rootScope) ->

		login: (email, password) ->
			
			deferred = $q.defer()

			Session = $resource("/api/authentification/login")
			
			user = Session.save {},  { username: email, password: password }, 
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
					deferred.resolve()
				.error (data) =>
					@session = false
					$rootScope.user = @user()
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
						deferred.resolve()
					.error (data) =>
						@session = false
						deferred.reject code: 403				

			deferred.promise

		security: (rule) ->
			rules[rule](@user())

		getUserKey: ->
			@user()._id ? "guest"

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
			JSON.parse(jsonData)

		# checks if some data was stored for that user in localstorage
		hasLocal: (dataKey) ->
			retrieveLocal(dataKey)?

		
		isSessionFetched: ->
			# session isnt null/undefined or explicitily false
			@session?
			





			







