define [
	"require"
	"angular"
	"app"
	"states"
	"config"
], (require, ng) ->

	require ["domReady!"], (document) -> 

		# Bootstrap Angular when the dom is ready
		ng.bootstrap document, ["app"]