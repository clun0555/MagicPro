define [
	"underscore"
	"../blog-states"	
], (_, blog) ->

	blog.controller "BlogArticleController", ($scope, article) ->
		$scope.article = article


					
		


