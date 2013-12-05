
define ["require", "angular", "app", "routes"], (require, ng) ->
	
	
	#
	#     * place operations that need to initialize prior to app start here
	#     * using the `run` function on the top-level module
	#     
	require ["domReady!"], (document) ->
		ng.bootstrap document, ["app"]