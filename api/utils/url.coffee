url = require('url')
_ = require('underscore')

###
	Extension of node's standard url module
###

module.exports = 

	# Just augments returned object by spliting auth in login/password
	parse: (href) ->
		
		path = url.parse href

		[path.login, path.password] = path.auth.split ':' if path.auth?

		path

	# allows login/password to be passed in instead of auth
	format: (path) ->
		
		path.auth = path.login + ":" + path.password if path.login? and path.password?

		url.format path		

	# augments path with missing information
	process: (path) ->
		# need at least href or hostname
		return false unless path.href? or path.hostname?
		
		# need a protocol if not href
		return false if not path.protocol? and not path.href?

		if path.href?
			_.extend path, @parse(path.href)
		else
			path.href = @format(path)
			path

					
		
		




