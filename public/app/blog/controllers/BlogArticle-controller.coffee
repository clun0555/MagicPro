define [
	"underscore"
	"../blog-states"	
], (_, blog) ->

	blog.controller "BlogArticleController", ($scope, article, $modal) ->
		$scope.article = article

		$scope.editArticle = (article) ->
			$modal.open(
				templateUrl: "app/blog/views/edit_article.html"
				controller: "BlogArticleEditController"
				resolve:
					article: -> article						
						
			)