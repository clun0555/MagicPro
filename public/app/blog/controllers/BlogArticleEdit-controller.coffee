define [
	"underscore"
	"../blog-states"	
], (_, blog) ->

	blog.controller "BlogArticleEditController", ($scope, $modalInstance, article, BlogService) ->
		$scope.article = article

		$scope.save = ->
			BlogService.save($scope.article).then (article) ->
				console.log article
				$modalInstance.close(article)


					
		


