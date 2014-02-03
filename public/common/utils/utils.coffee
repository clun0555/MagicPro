define [
	"underscore"
], (_) ->

	getQueryParams: (queryString) ->
		query = (queryString or window.location.search).substring(1) # delete ?
		return false  unless query
		_.chain(query.split("&")).map((params) ->
			p = params.split("=")
			[p[0], decodeURIComponent(p[1])]
		).object().value()

	sortBy: (field, reverse, primer) ->
		key = (if primer then ((x) -> primer x[field]) else ((x) -> x[field]))
		
		reverse = [-1, 1][+!!reverse]
		
		(a, b) ->
			a = key(a)
			b = key(b)
			reverse * ((a > b) - (b > a))
