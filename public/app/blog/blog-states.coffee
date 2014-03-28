define [
	"angular"
], (ng) ->

	ng
		.module('app.blog', ["ui.router"])

		.config ( $stateProvider ) ->
				
			$stateProvider

				.state "blog",
					url: "/blog"
					parent: "layout"
					templateUrl: "app/blog/views/articles.html"
					controller: "BlogArticlesController"					
					resolve: 
						articles: (BlogService) -> BlogService.getArticles() 

				.state "article",
					url: "/blog/:articleId"
					parent: "layout"					
					templateUrl: "app/blog/views/article.html"
					controller: "BlogArticleController"					
					resolve: 
						article: (BlogService, $stateParams) -> BlogService.getArticle($stateParams.articleId) 					
