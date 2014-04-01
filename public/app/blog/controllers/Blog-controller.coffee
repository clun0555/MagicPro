define [
	"underscore"
	"../blog-states"	
], (_, blog) ->

	blog.controller "BlogController", ($scope, $modal, BlogService, $state) ->		

		$scope.editArticle = (article) ->
			$modal.open(
					templateUrl: "app/blog/views/edit_article.html"
					controller: "BlogArticleEditController"
					resolve:
						article: -> article						
							
				).result.then ->
					$state.reload()
					# alert "r"

		$scope.createArticle = ->
			$scope.editArticle({ status: "draft", category: "news" })		