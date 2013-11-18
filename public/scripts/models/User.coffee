define [
	"Base"
], (Base) ->
	
	class User extends Base.Model

		urlRoot: "/api/users"

		isAdmin: ->
			@get("role") is "admin"

		is: (role) ->
			@get("role") is role

