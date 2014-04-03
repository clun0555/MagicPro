define [
	"underscore"
	"../blog-states"	
], (_, blog) ->

	blog.controller "BlogController", ($scope, $modal, BlogService, $state, $stateParams) ->		

		$scope.editArticle = (article) ->
			$modal.open(
					templateUrl: "app/blog/views/edit_article.html"
					controller: "BlogArticleEditController"
					resolve:
						article: -> article						
							
				).result.then ->
					# reloads the currentState
					$state.transitionTo($state.current, $stateParams, { reload: true, inherit: true, notify: true })
					

		$scope.createArticle = ->
			$scope.editArticle({ status: "draft", category: "news" })		