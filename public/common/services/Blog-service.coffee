define [
	"./services"
	"underscore"
	"common/utils/utils"
], (services, _, utils) ->	

	services.service "BlogService", ($resource, $q) ->

		Articles = $resource "/api/articles/:id", { "_id": "@id"}, { 'update': {method:'PUT'} }

		
		getArticles: ->
			deferred = $q.defer()

			if @articles?
				deferred.resolve @articles
			else
				articles = $resource("api/articles").query =>
					@articles = articles
					@articles = @articles.sort utils.sortBySorter('createdOn', false, (d) -> d?.toString())
					# @articles = _.sortBy(articles, "createdOn", true)

					deferred.resolve @articles

			deferred.promise

		getArticle: (articleId) ->
			deferred = $q.defer()

			@getArticles().then (articles) =>
					deferred.resolve _.findWhere(articles, {'_id': articleId})

			deferred.promise

		save: (article) ->
			if article._id?
				Articles.update( { id: article._id }, article ).$promise.then (article) =>
					# todo replace article in  @articles with new one

			else
				Articles.save( { }, article).$promise.then (article) => @articles.unshift article

		remove: (article) ->
			Articles.remove({ id: article._id }, article).$promise.then => @articles.splice @articles.indexOf(article), 1





		
