define [
	"angular"
], (ng) ->

	ng
		.module('app.blog', ["ui.router"])

		.config ( $stateProvider ) ->
				
			$stateProvider

				.state "blog",
					url: "/blog"
					templateUrl: "app/blog/views/articles.html"
					controller: "BlogArticlesController"
					parent: "layout"
					resolve: 
						articles: (BlogService) -> BlogService.getArticles() 					
