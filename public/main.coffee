require [
	"common/libraries"
], ->

	require [
		"require"
		"angular"
		"app"
		"common/states"
		"common/config"
	], (require, ng) ->

		require ["domReady!"], (document) -> 

			# Bootstrap Angular when the dom is ready
			ng.bootstrap document, ["app"]