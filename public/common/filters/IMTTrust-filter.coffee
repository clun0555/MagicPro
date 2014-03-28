define [
	"./filters"
], (filters) ->
	filters.filter 'imt_trust', ($sce) -> 
		(text) -> $sce.trustAsHtml text