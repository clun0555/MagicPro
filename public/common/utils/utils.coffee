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
