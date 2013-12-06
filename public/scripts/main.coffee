
define ["require", "angular", "app", "routes", "config"], (require, ng) ->

	require ["domReady!"], (document) -> ng.bootstrap document, ["app"]