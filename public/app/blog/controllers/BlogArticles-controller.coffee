define [
	"underscore"
	"../blog-states"	
], (_, blog) ->

	blog.controller "BlogArticlesController", ($scope, $modal, articles, BlogService, $state, $stateParams, $translate) ->		

		$scope.articles = articles

		# $scope.editArticle = (article) ->
		# 	$modal.open(
		# 			templateUrl: "app/blog/views/edit_article.html"
		# 			controller: "BlogArticleEditController"
		# 			resolve:
		# 				article: -> article						
							
		# 		)
			# .result.then (article) ->
			# 		$scope.articles.push article
					# $scope.product.type = type	

	

		$scope.removeArticle = (article) ->
			msg = $translate('article.remove.confirmation', {title: article.title})
			if confirm(msg)
				BlogService.remove(article).then ->
					$scope.articles.splice($scope.articles.indexOf(article), 1)
				# reloads the currentState
				# $state.transitionTo($state.current, $stateParams, { reload: true, inherit: true, notify: true })
				