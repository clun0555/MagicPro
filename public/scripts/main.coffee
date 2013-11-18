
###
	Application starter. 
	Loads requirejs config.
	Starts application when dom is ready
###

require ["base/libraries"], (config) ->
	require [ "jquery", "Initializer" ], ($, Initializer) -> $ -> 
		Initializer.bootstrap()