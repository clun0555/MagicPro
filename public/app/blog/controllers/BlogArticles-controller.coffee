define [
	"underscore"
	"../blog-states"	
], (_, blog) ->

	blog.controller "BlogArticlesController", ($scope, $modal, articles, BlogService) ->		

		$scope.articles = articles

		$scope.editArticle = (article) ->
			$modal.open(
					templateUrl: "app/blog/views/edit_article.html"
					controller: "BlogArticleEditController"
					resolve:
						article: -> article						
							
				)
			# .result.then (article) ->
			# 		$scope.articles.push article
					# $scope.product.type = type	

		$scope.createArticle = ->
			$scope.editArticle({ status: "draft"})		

		$scope.removeArticle = (article) ->
			BlogService.remove article		
		